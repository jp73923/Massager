//
//  ThirdOnBoardingVC.swift
//  Massager
//
//  Created by Jay on 01/06/22.
//

import UIKit
import KDCircularProgress
import StoreKit

class ThirdOnBoardingVC: UIViewController {
    var progress: KDCircularProgress!
    var progressAddTimer = Timer()
    var progressRuningTimer = Timer()
    var progressCounter = Timer()
    var counter = 5
    var isPresent = false
    
    @IBOutlet weak var vwSubscribe: UIView!
    @IBOutlet weak var vwProgress: UIView!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var shrimmerView: ShimmerView!
    @IBOutlet weak var lblText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwSubscribe.clipsToBounds = true
        self.vwSubscribe.layer.cornerRadius = 15.0
        
        self.shrimmerView.clipsToBounds = true
        self.shrimmerView.layer.cornerRadius = 15.0
        
        self.btnClose.isHidden = true
        
        self.progressAddTimer.invalidate()
        self.progressAddTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.addProgressView), userInfo: nil, repeats: true)
        
        self.progressRuningTimer.invalidate()
        self.progressRuningTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.addProgressRuningView), userInfo: nil, repeats: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(tap:)))
        self.lblText.addGestureRecognizer(tap)
        self.lblText.isUserInteractionEnabled = true

    }
    @objc func tapLabel(tap:UIGestureRecognizer) {
        if tap.location(in: self.view).y > 550 {
            if tap.location(in: self.view).x > 104 && tap.location(in: self.view).x < 284 {
                guard let url = URL(string: "http://luckydevapplelt.epizy.com/terms_of_use") else { return }
                UIApplication.shared.openURL(url)
            } else {
                guard let url = URL(string: "http://luckydevapplelt.epizy.com/private_policy_massager_apple") else { return }
                UIApplication.shared.openURL(url)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shrimmerView.startAnimating()
    }
    @objc func counterProgress() {
        counter = counter - 1
        if counter == 0 {
            self.lblCounter.isHidden = true
            self.vwProgress.isHidden = true
            self.btnClose.isHidden = false
            progressCounter.invalidate()
            return
        }
        self.lblCounter.text = "\(counter)"
    }
    @objc func addProgressView() {
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = false
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .noGlow
        progress.trackColor = UIColor.clear
        progress.set(colors: UIColor.init(red: 223/255, green: 210/255, blue: 235/255, alpha: 1.0) ,UIColor.init(red: 223/255, green: 210/255, blue: 235/255, alpha: 1.0), UIColor.init(red: 223/255, green: 210/255, blue: 235/255, alpha: 1.0), UIColor.init(red: 223/255, green: 210/255, blue: 235/255, alpha: 1.0), UIColor.init(red: 223/255, green: 210/255, blue: 235/255, alpha: 1.0))
        progress.center = self.vwProgress.center
        progress.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.vwProgress.addSubview(progress)
        self.progressAddTimer.invalidate()
        self.progressCounter.invalidate()
        self.progressCounter = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.counterProgress), userInfo: nil, repeats: true)
    }
    
    @objc func addProgressRuningView() {
        self.progressRuningTimer.invalidate()
        progress.animate(fromAngle: 0, toAngle: 360, duration: 5) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
    }
    
    @IBAction func btnCloseAction(_ sender: Any) {
        if isPresent {
            self.dismiss(animated: true, completion: nil)
        } else {
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idCustomTabbarVC)
            APP_DELEGATE.appNavigation = UINavigationController(rootViewController: vc)
            APP_DELEGATE.appNavigation?.interactivePopGestureRecognizer?.delegate = nil
            APP_DELEGATE.appNavigation?.interactivePopGestureRecognizer?.isEnabled = true
            APP_DELEGATE.appNavigation?.isNavigationBarHidden = true
            APP_DELEGATE.window?.rootViewController = APP_DELEGATE.appNavigation
            APP_DELEGATE.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func btnSubscribeAction(_ sender: Any) {
        InAppPurchase.sharedInstance.buyAutorenewableSubscription()
    }
    
    @IBAction func btnRestoreAction(_ sender: Any) {
        InAppPurchase.sharedInstance.restoreTransactions()
    }

}
