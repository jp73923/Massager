//
//  MainVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit
import Appodeal
import AVFoundation

class MainVC: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var vwBgHurricane: UIView!

    var vibrationTimer1 = Timer()
    var vibrationTimer2 = Timer()
    var vibrationTimer3 = Timer()
    var vibrationTimer4 = Timer()
    var vibrationTimer5 = Timer()

    var intensity = 5
    var player: AVAudioPlayer?

    @IBOutlet var lockButton: FaveButton?
    @IBOutlet var musicButton: FaveButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        Appodeal.setBannerDelegate(self)

        self.btn1.clipsToBounds = true
        self.btn1.layer.cornerRadius = 10.0
        self.btn2.clipsToBounds = true
        self.btn2.layer.cornerRadius = 10.0
        self.btn3.clipsToBounds = true
        self.btn3.layer.cornerRadius = 10.0
        self.btn4.clipsToBounds = true
        self.btn4.layer.cornerRadius = 10.0
        self.btn5.clipsToBounds = true
        self.btn5.layer.cornerRadius = 10.0
        self.vwBgHurricane.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        self.vwBgHurricane.layer.borderWidth = 5.0
        self.vwBgHurricane.layer.cornerRadius = 15.0
        
        self.lockButton?.setSelected(selected: true, animated: false)
        self.musicButton?.setSelected(selected: true, animated: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabChanged), name: Notification.Name("changeTab"), object: nil)
        
        Appodeal.showAd(.bannerBottom, forPlacement: "", rootViewController: self)
    }
    // MARK: Setup
    @objc func tabChanged() {
        self.vibrationTimer1.invalidate()
        self.vibrationTimer2.invalidate()
        self.vibrationTimer3.invalidate()
        self.vibrationTimer4.invalidate()
        self.vibrationTimer5.invalidate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @objc func update1() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    @objc func update2() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    @objc func update3() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func update4() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func update5() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    @IBAction func btnMoveToPattern(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("moveToPatternTab"), object: nil)
    }
    @IBAction func btnLockAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LockVC") as! LockVC
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnMusicAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MusicVC") as! MusicVC
        self.presentPanModal(vc)
    }
    @IBAction func btnVibrationIntencityAction(_ sender: UIButton) {
        self.btn1.backgroundColor = UIColor.white
        self.btn2.backgroundColor = UIColor.white
        self.btn3.backgroundColor = UIColor.white
        self.btn4.backgroundColor = UIColor.white
        self.btn5.backgroundColor = UIColor.white
        intensity = sender.tag
        
        if sender.tag == 1 {
            self.btn1.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn2.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer1.invalidate()
            vibrationTimer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update1), userInfo: nil, repeats: true)
        } else if sender.tag == 2 {
            self.btn2.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer2.invalidate()
            vibrationTimer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update2), userInfo: nil, repeats: true)
        } else if sender.tag == 3 {
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer3.invalidate()
            vibrationTimer3 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update3), userInfo: nil, repeats: true)
        } else if sender.tag == 4 {
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer4.invalidate()
            vibrationTimer4 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update4), userInfo: nil, repeats: true)
        } else if sender.tag == 5 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            vibrationTimer5.invalidate()
            vibrationTimer5 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update5), userInfo: nil, repeats: true)
        }
        self.playSound(soundName: APP_DELEGATE.musicSelected, soundExtension: APP_DELEGATE.musicExtensionSelected)
    }
    
    func playSound(soundName:String,soundExtension:String) {
        if soundName == "NO" {
            player?.stop()
            return
        }
        let url = Bundle.main.url(forResource: soundName, withExtension: soundExtension)!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }

}
//MARK: - AppodealBannerViewDelegate
extension MainVC: AppodealBannerDelegate {
    func bannerDidLoadAdIsPrecache(_ precache: Bool) {}
    func bannerDidFailToLoadAd() {}
    func bannerDidClick() {}
    func bannerDidShow() {}
}
