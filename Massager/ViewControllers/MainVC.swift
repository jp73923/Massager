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
    @IBOutlet weak var bannerView: APDBannerView!
    @IBOutlet weak var vwSliderSelection: UIView!
    @IBOutlet weak var silder: UISlider!
    @IBOutlet weak var btnSelectedPattern: UIButton!
    @IBOutlet weak var imgbtnBg1: UIImageView!
    @IBOutlet weak var imgbtnBg2: UIImageView!

    var vibrationTimer1 = Timer()
    var vibrationTimer2 = Timer()
    var vibrationTimer3 = Timer()
    var vibrationTimer4 = Timer()
    var vibrationTimer5 = Timer()

    var intensity = 5
    var player: AVAudioPlayer?
    private static let heartbeatHapticFilename: String = "Heartbeat"

    @IBOutlet var lockButton: FaveButton?
    @IBOutlet var musicButton: FaveButton?
    var vibrationTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
       // Appodeal.setBannerDelegate(self)
        
        let bannerSize = kAPDAdSize320x50
        bannerView.adSize = bannerSize
        bannerView.loadAd()

        self.imgbtnBg1.clipsToBounds = true
        self.imgbtnBg1.layer.cornerRadius = 40.0
        self.imgbtnBg2.clipsToBounds = true
        self.imgbtnBg2.layer.cornerRadius = 40.0
        
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
        
        self.silder.transform = self.silder.transform.rotated(by: 270.0/180*M_PI);
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.silder.addGestureRecognizer(tap)
                
        if APP_DELEGATE.strSelectedPattern != "" {
            self.btnSelectedPattern.setBackgroundImage(UIImage.init(named: APP_DELEGATE.strSelectedPattern.lowercased()), for: UIControl.State.normal)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(tabChangedToPatternMain), name: Notification.Name("tabChangedToPatternMain"), object: nil)
    }
    // MARK: Setup
    @objc func hurricane() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func storm() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func explosion() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    @objc func balance() {
        Vibrator.shared.startHaptic(named: MainVC.heartbeatHapticFilename, loop: true)
    }
    @objc func wind() {
        Vibrator.shared.startVibrate(frequency: .high, loop: true)
    }
    @objc func volcano() {
        Vibrator.shared.startVibrate(loop: false)
    }
    @objc func landflake() {
        Vibrator.shared.startHaptic(named: MainVC.heartbeatHapticFilename, loop: true)
    }
    @objc func fire() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func rain() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc func whirlpool() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    func patternVibration(patternType:String) {
        //["Hurricane","Hurricane2","Wave","Waterfall","Explosion","Stones","Wind","Snowflake","Volcano","Danger","Landslide","Rain","Sun"]
        switch patternType {
        case "Hurricane":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.hurricane), userInfo: nil, repeats: true)
            break
        case "Hurricane2":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.whirlpool), userInfo: nil, repeats: true)
            break
        case "Wave":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.storm), userInfo: nil, repeats: true)
            break
        case "Waterfall":
            Vibrator.shared.startHaptic(named: MainVC.heartbeatHapticFilename, loop: true)
            break
        case "Explosion":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.explosion), userInfo: nil, repeats: true)
            break
        case "Stones":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.balance), userInfo: nil, repeats: true)
            break
        case "Wind":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.wind), userInfo: nil, repeats: true)
            break
        case "Snowflake":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.wind), userInfo: nil, repeats: true)
            break
        case "Volcano":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.volcano), userInfo: nil, repeats: true)
            break
        case "Danger":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.fire), userInfo: nil, repeats: true)
            break
        case "Landslide":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.landflake), userInfo: nil, repeats: true)
            break
        case "Rain":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.rain), userInfo: nil, repeats: true)
            break
        case "Sun":
            Vibrator.shared.startHaptic(named: MainVC.heartbeatHapticFilename, loop: true)
            break
        default:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            break
        }
    }
    @objc func tabChangedToPatternMain() {
        self.btn1.backgroundColor = UIColor.white
        self.btn2.backgroundColor = UIColor.white
        self.btn3.backgroundColor = UIColor.white
        self.btn4.backgroundColor = UIColor.white
        self.btn5.backgroundColor = UIColor.white
        self.btnSelectedPattern.setBackgroundImage(UIImage.init(named: APP_DELEGATE.strSelectedPattern.lowercased()), for: UIControl.State.normal)
        self.vibrationTimer.invalidate()
        Vibrator.shared.stopHaptic()
        Vibrator.shared.stopVibrate()
        self.silder.value = 0.0
       // self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let pointTapped: CGPoint = sender.location(in: self.view)

        let positionOfSlider: CGPoint = self.silder.frame.origin
        let widthOfSlider: CGFloat = self.silder.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(self.silder.maximumValue) / widthOfSlider)

        self.silder.setValue(Float(newValue)/10, animated: true)
        self.sliderChanged(self.silder)
    }
    @objc func tabChanged() {
        self.vibrationTimer1.invalidate()
        self.vibrationTimer2.invalidate()
        self.vibrationTimer3.invalidate()
        self.vibrationTimer4.invalidate()
        self.vibrationTimer5.invalidate()
        if APP_DELEGATE.strSelectedPattern != "" {
            self.btnSelectedPattern.setBackgroundImage(UIImage.init(named: APP_DELEGATE.strSelectedPattern.lowercased()), for: UIControl.State.normal)
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        print(sender.value)
        self.btn1.backgroundColor = UIColor.white
        self.btn2.backgroundColor = UIColor.white
        self.btn3.backgroundColor = UIColor.white
        self.btn4.backgroundColor = UIColor.white
        self.btn5.backgroundColor = UIColor.white
        intensity = sender.tag
        if sender.value > 0.1 && sender.value < 0.20 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            if APP_DELEGATE.strSelectedPattern != "" { } else {
                vibrationTimer5.invalidate()
                vibrationTimer5 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update5), userInfo: nil, repeats: true)
            }
        } else if sender.value > 0.20 && sender.value < 0.40 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            if APP_DELEGATE.strSelectedPattern != "" { } else {
                vibrationTimer4.invalidate()
                vibrationTimer4 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update4), userInfo: nil, repeats: true)
            }
        } else if sender.value > 0.40 && sender.value < 0.60 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            if APP_DELEGATE.strSelectedPattern != "" { } else {
                vibrationTimer3.invalidate()
                vibrationTimer3 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update3), userInfo: nil, repeats: true)
            }
        } else if sender.value > 0.60 && sender.value < 0.80 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn2.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            if APP_DELEGATE.strSelectedPattern != "" { } else {
                vibrationTimer2.invalidate()
                vibrationTimer2 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update2), userInfo: nil, repeats: true)
            }
        } else if sender.value > 0.80 && sender.value <= 1 {
            self.btn5.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn4.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn3.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn2.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            self.btn1.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
            if APP_DELEGATE.strSelectedPattern != "" { } else {
                vibrationTimer1.invalidate()
                vibrationTimer1 = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.update1), userInfo: nil, repeats: true)
            }
        } else {
            vibrationTimer1.invalidate()
            vibrationTimer2.invalidate()
            vibrationTimer3.invalidate()
            vibrationTimer4.invalidate()
            vibrationTimer5.invalidate()
            self.vibrationTimer.invalidate()
            Vibrator.shared.stopHaptic()
            Vibrator.shared.stopVibrate()
            self.playSound(soundName: "NO", soundExtension: APP_DELEGATE.musicExtensionSelected)
            return
        }
        if APP_DELEGATE.strSelectedPattern != "" {
            self.vibrationTimer.invalidate()
            self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
        }
        if APP_DELEGATE.musicSelected != "" {
            self.playSound(soundName: APP_DELEGATE.musicSelected, soundExtension: APP_DELEGATE.musicExtensionSelected)
        }
    }
    @objc func update1() {
        if APP_DELEGATE.strSelectedPattern != "" {
            
        } else {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
    }
    @objc func update2() {
       /* if APP_DELEGATE.strSelectedPattern != "" {
          //  self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
        } else {*/
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
       // }
    }
    @objc func update3() {
        /*if APP_DELEGATE.strSelectedPattern != "" {
           // self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
        } else {*/
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
       // }
    }
    @objc func update4() {
       /* if APP_DELEGATE.strSelectedPattern != "" {
           // self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
        } else {*/
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        //}
    }
    @objc func update5() {
      /*  if APP_DELEGATE.strSelectedPattern != "" {
           // self.patternVibration(patternType: APP_DELEGATE.strSelectedPattern)
        } else {*/
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
       // }
    }
    @IBAction func btnMoveToPattern(_ sender: UIButton) {
        self.btn1.backgroundColor = UIColor.white
        self.btn2.backgroundColor = UIColor.white
        self.btn3.backgroundColor = UIColor.white
        self.btn4.backgroundColor = UIColor.white
        self.btn5.backgroundColor = UIColor.white
        self.btnSelectedPattern.setBackgroundImage(UIImage.init(named: APP_DELEGATE.strSelectedPattern.lowercased()), for: UIControl.State.normal)
        self.vibrationTimer.invalidate()
        Vibrator.shared.stopHaptic()
        Vibrator.shared.stopVibrate()
        self.silder.value = 0.0
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
        if APP_DELEGATE.musicSelected != "" {
            self.playSound(soundName: APP_DELEGATE.musicSelected, soundExtension: APP_DELEGATE.musicExtensionSelected)
        }
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
