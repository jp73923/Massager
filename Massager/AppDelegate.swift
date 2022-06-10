//
//  AppDelegate.swift
//  Massager
//
//  Created by Jay on 25/05/22.
//

import UIKit
import Appodeal
import StackConsentManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appNavigation:UINavigationController?
    var window:UIWindow?
    var musicSelected = ""
    var musicExtensionSelected = ""

    private struct AppodealConstants {
        static let key: String = "a14483d2951585a941294c8614069ed5284e5fdc0ea34a03"
        static let adTypes: AppodealAdType = [.interstitial, .rewardedVideo, .banner, .nativeAd]
        static let logLevel: APDLogLevel = .debug
        static let testMode: Bool = false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Vibrator.shared.prepare()
        //Ads Integration Code
        synchroniseConsent()
        configureAppearance()
        return true
    }
    
    // MARK: Appodeal Initialization
    private func initializeAppodealSDK() {
        /// Custom settings
        // Appodeal.setFramework(.native, version: "1.0.0")
        // Appodeal.setTriggerPrecacheCallbacks(true)
        // Appodeal.setLocationTracking(true)
        
        /// Test Mode
        Appodeal.setTestingEnabled(AppodealConstants.testMode)
        
        /// User Data
        // Appodeal.setUserId("userID")
        // Appodeal.setUserAge(25)
        // Appodeal.setUserGender(.male)
        Appodeal.setLogLevel(AppodealConstants.logLevel)
        Appodeal.setAutocache(true, types: AppodealConstants.adTypes)
        // Initialise Appodeal SDK with consent report
        if let consent = STKConsentManager.shared().consent {
            Appodeal.initialize(
                withApiKey: AppodealConstants.key,
                types: AppodealConstants.adTypes,
                hasConsent: consent as? Bool ?? false
            )
        } else {
            Appodeal.initialize(
                withApiKey: AppodealConstants.key,
                types: AppodealConstants.adTypes
            )
        }
    }
    
    // MARK: Consent manager
    private func synchroniseConsent() {
        STKConsentManager.shared().synchronize(withAppKey: AppodealConstants.key) { error in
            error.map { print("Error while synchronising consent manager: \($0)") }
            guard STKConsentManager.shared().shouldShowConsentDialog == .true else {
                self.initializeAppodealSDK()
                return
            }
            
            STKConsentManager.shared().loadConsentDialog { [unowned self] error in
                error.map { print("Error while loading consent dialog: \($0)") }
                guard let controller = self.window?.rootViewController, STKConsentManager.shared().isConsentDialogReady else {
                    self.initializeAppodealSDK()
                    return
                }
                
                STKConsentManager.shared().showConsentDialog(fromRootViewController: controller,
                                                             delegate: self)
            }
        }
    }
    
    // MARK: Appearance
    private func configureAppearance() {
        let navBarAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarAttributes, for: .highlighted)
        
        UITabBar.appearance().tintColor = .white
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = .lightGray
        }
    }
}


extension AppDelegate: STKConsentManagerDisplayDelegate {
    func consentManagerWillShowDialog(_ consentManager: STKConsentManager) {}
    
    func consentManager(_ consentManager: STKConsentManager, didFailToPresent error: Error) {
        initializeAppodealSDK()
    }
    
    func consentManagerDidDismissDialog(_ consentManager: STKConsentManager) {
        initializeAppodealSDK()
    }
}
