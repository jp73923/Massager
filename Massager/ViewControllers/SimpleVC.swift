//
//  SimpleVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit
import Appodeal

class SimpleVC: UIViewController {
    @IBOutlet weak var btnInputOutput: UIButton!
    @IBOutlet weak var vwInputOutput: UIView!
    @IBOutlet weak var sliderVibration: UISlider!
    @IBOutlet weak var sliderPauseTime: UISlider!
  //  @IBOutlet weak var bannerView: APDBannerView!
    @IBOutlet weak var imgbtnBg1: UIImageView!
    @IBOutlet weak var imgbtnBg2: UIImageView!

    var vibrationTimer = Timer()
    var intensity = 1
    var pauseTime = 0.01
    var vibrationOn = false
    
    @IBOutlet var lockButton: FaveButton?
    @IBOutlet var musicButton: FaveButton?

    override func viewDidLoad() {
      /*  super.viewDidLoad()
        let bannerSize = kAPDAdSize320x50
        bannerView.adSize = bannerSize
        bannerView.loadAd()*/
        
        self.imgbtnBg1.clipsToBounds = true
        self.imgbtnBg1.layer.cornerRadius = 40.0
        self.imgbtnBg2.clipsToBounds = true
        self.imgbtnBg2.layer.cornerRadius = 40.0
        
        self.vwInputOutput.clipsToBounds = true
        self.vwInputOutput.layer.cornerRadius = self.vwInputOutput.frame.size.width/2
        
        self.lockButton?.setSelected(selected: true, animated: false)
        self.musicButton?.setSelected(selected: true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabChangedToPatternMain), name: Notification.Name("tabChangedToPatternMain"), object: nil)
    }
    @objc func tabChangedToPatternMain() {
        self.vibrationOn = false
        self.btnInputOutput.isSelected = false
        self.btnInputOutput.setTitle("I", for: UIControl.State.normal)
        self.btnInputOutput.backgroundColor = UIColor.init(red: 247.0/255.0, green: 137.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        self.vibrationTimer.invalidate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vibrationTimer.invalidate()
    }
    @objc func update() {
        switch intensity {
        case 1:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            break
        case 2:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            break
        case 3:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            break
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            break
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            break
        default:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            break
        }
    }
    @IBAction func sliderPauseTimeChanged(_ sender: UISlider) {
        self.pauseTime = Double(Float(sender.value))
        if self.vibrationOn {
            vibrationTimer.invalidate()
            vibrationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.pauseTime), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
    @IBAction func sliderVibrationIntensityChanged(_ sender: UISlider) {
        self.intensity = Int(sender.value)
        vibrationTimer.invalidate()
        if self.vibrationOn {
            vibrationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.pauseTime), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
    @IBAction func btnMusicAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MusicVC") as! MusicVC
        self.presentPanModal(vc)
    }
    @IBAction func btnLockAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LockVC") as! LockVC
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnVibrationIntencityAction(_ sender: UIButton) {
        if self.btnInputOutput.isSelected {
            self.vibrationOn = false
            self.btnInputOutput.isSelected = false
            self.btnInputOutput.setTitle("I", for: UIControl.State.normal)
            self.btnInputOutput.backgroundColor = UIColor.init(red: 247.0/255.0, green: 137.0/255.0, blue: 209.0/255.0, alpha: 1.0)
            vibrationTimer.invalidate()
        } else {
            self.vibrationOn = true
            self.btnInputOutput.isSelected = true
            self.btnInputOutput.setTitle("O", for: UIControl.State.normal)
            self.btnInputOutput.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer.invalidate()
            vibrationTimer = Timer.scheduledTimer(timeInterval: self.pauseTime, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
}
