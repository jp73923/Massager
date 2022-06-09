//
//  VibrationVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit

class VibrationVC: UIViewController {
    @IBOutlet weak var heightNoVibration: NSLayoutConstraint!
    @IBOutlet weak var heightWantStronger: NSLayoutConstraint!
    @IBOutlet weak var imgVibration: UIImageView!
    @IBOutlet weak var imgVibrationStronger: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNoVibrationAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            UIView.animate(withDuration: 0.3) {
                self.heightNoVibration.constant = 0.0
                self.view.layoutIfNeeded()
            }
            self.imgVibration.image = UIImage.init(named: "ic_down")
        } else {
            sender.isSelected = true
            UIView.animate(withDuration: 0.3) {
                self.heightNoVibration.constant = 150.0
                self.view.layoutIfNeeded()
            }
            self.imgVibration.image = UIImage.init(named: "ic_up")
        }
    }
    @IBAction func btnWantStrongerAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            UIView.animate(withDuration: 0.3) {
                self.heightWantStronger.constant = 0.0
                self.view.layoutIfNeeded()
            }
            self.imgVibrationStronger.image = UIImage.init(named: "ic_down")
        } else {
            sender.isSelected = true
            UIView.animate(withDuration: 0.3) {
                self.heightWantStronger.constant = 170.0
                self.view.layoutIfNeeded()
            }
            self.imgVibrationStronger.image = UIImage.init(named: "ic_up")
        }
    }
    @IBAction func btnSettingAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}

