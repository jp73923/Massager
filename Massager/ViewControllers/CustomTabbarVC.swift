//
//  ViewController.swift
//  Massager
//
//  Created by Jay on 25/05/22.
//

import UIKit


class CustomTabbarVC: UIViewController {
    @IBOutlet weak var oneContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var thirdContainerView: UIView!
    @IBOutlet weak var leadingSelector: NSLayoutConstraint!
    @IBOutlet weak var patternTop: NSLayoutConstraint!
    @IBOutlet weak var patternBottom: NSLayoutConstraint!
    @IBOutlet weak var mainTop: NSLayoutConstraint!
    @IBOutlet weak var mainBottom: NSLayoutConstraint!
    @IBOutlet weak var simpleTop: NSLayoutConstraint!
    @IBOutlet weak var simpleBottom: NSLayoutConstraint!
    @IBOutlet weak var btnNoVibration: UIButton!
    @IBOutlet weak var lblNoVibration: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.leadingSelector.constant = UIScreen.main.bounds.size.width/3
        NotificationCenter.default.addObserver(self, selector: #selector(moveToTab), name: Notification.Name("moveToPatternTab"), object: nil)
        if UserDefaultManager.getBooleanFromUserDefaults(key: "isWatchTutorial") {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "page3") as! ThirdOnBoardingVC
            vc.modalPresentationStyle = .fullScreen
            vc.isPresent = true
            APP_DELEGATE.appNavigation?.present(vc, animated: true, completion: nil)
        } else {
            UserDefaultManager.setBooleanToUserDefaults(value: true, key: "isWatchTutorial")
        }
        self.lblNoVibration.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO VIBRATION?", comment: "")
    }
    
    @objc func moveToTab() {
        self.oneContainerView.isHidden = false
        self.secondContainerView.isHidden = true
        self.thirdContainerView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.patternTop.constant = -40.0
            self.patternBottom.constant = 15.0
            self.mainTop.constant = 15.0
            self.mainBottom.constant = -40.0
            self.simpleTop.constant = 15.0
            self.simpleBottom.constant = -40.0
            self.leadingSelector.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func btnSettingAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnVibrationVCAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VibrationVC") as! VibrationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPattternAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("tabChangedToPatternMain"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("changeTab"), object: nil)

        self.oneContainerView.isHidden = false
        self.secondContainerView.isHidden = true
        self.thirdContainerView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.patternTop.constant = -40.0
            self.patternBottom.constant = 15.0
            self.mainTop.constant = 15.0
            self.mainBottom.constant = -40.0
            self.simpleTop.constant = 15.0
            self.simpleBottom.constant = -40.0
            self.leadingSelector.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func btnVibrationAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("tabChangedToPatternMain"), object: nil)

        self.oneContainerView.isHidden = true
        self.secondContainerView.isHidden = false
        self.thirdContainerView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.mainTop.constant = -40.0
            self.mainBottom.constant = 15.0
            self.patternTop.constant = 15.0
            self.patternBottom.constant = -40.0
            self.simpleTop.constant = 15.0
            self.simpleBottom.constant = -40.0
            self.leadingSelector.constant = UIScreen.main.bounds.size.width/3
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func btnSimpleAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("changeTab"), object: nil)
    
        self.oneContainerView.isHidden = true
        self.secondContainerView.isHidden = true
        self.thirdContainerView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.simpleTop.constant = -40.0
            self.simpleBottom.constant = 15.0
            self.patternTop.constant = 15.0
            self.patternBottom.constant = -40.0
            self.mainTop.constant = 15.0
            self.mainBottom.constant = -40.0
            self.leadingSelector.constant = (UIScreen.main.bounds.size.width/3)*2
            self.view.layoutIfNeeded()
        }
    }
}


