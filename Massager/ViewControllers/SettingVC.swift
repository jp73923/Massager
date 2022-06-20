//
//  SettingVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit
import StoreKit

class SettingVC: UIViewController {
    @IBOutlet weak var btnNoVibration: UIButton!
    @IBOutlet weak var btnRateApp: UIButton!
    @IBOutlet weak var btnShareApp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnNoVibration.clipsToBounds = true
        self.btnNoVibration.layer.cornerRadius = 21.0
        self.btnRateApp.clipsToBounds = true
        self.btnRateApp.layer.cornerRadius = 21.0
        self.btnShareApp.clipsToBounds = true
        self.btnShareApp.layer.cornerRadius = 21.0
        
        self.btnNoVibration.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        self.btnNoVibration.layer.borderWidth = 2.0
        self.btnRateApp.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        self.btnRateApp.layer.borderWidth = 2.0
        self.btnShareApp.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        self.btnShareApp.layer.borderWidth = 2.0
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnVibrationAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VibrationVC") as! VibrationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnShareAction(_ sender: UIButton) {
        let items = [URL(string: "https://apps.apple.com/us/app/vibrator-strong-massage-calm/id1628353413")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    @IBAction func btnRateAppAction(_ sender: UIButton) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1628353413?mt=8") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
