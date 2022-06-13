//
//  PatternVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit
import Appodeal


class cellPattern:UICollectionViewCell {
    @IBOutlet weak var imgPattern: UIImageView!
    @IBOutlet weak var lblPattern: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var vwLock: UIView!
}
class PatternVC: UIViewController {

    @IBOutlet weak var clvPattern: UICollectionView!
    @IBOutlet weak var btnInputOutput: UIButton!
    @IBOutlet weak var vwInputOutput: UIView!

    var arrPatterns = ["Hurricane","Whirlpool","Strom","Waterfall","Explosion","Balance","Wind","Snowflake","Volcano","Fire","Landslide","Rain","Sun"]
    var arrPatternsImages = ["Hurricane","Hurricane2","Wave","Waterfall","Explosion","Stones","Wind","Snowflake","Volcano","Danger","Landslide","Rain","Sun"]
    var arrSelection = [1,0,0,0,0,0,0,0,0,0,0,0,0]
    var vibrationTimer = Timer()
    var isOnVibration = false
    var selectedPattern = 0
    var previousSelectionIndex = 0
    var countThree = 0

    private static let heartbeatHapticFilename: String = "Heartbeat"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwInputOutput.clipsToBounds = true
        self.vwInputOutput.layer.cornerRadius = 50.0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.vibrationTimer.invalidate()
        Vibrator.shared.stopHaptic()
        Vibrator.shared.stopVibrate()
    }
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
        Vibrator.shared.startHaptic(named: PatternVC.heartbeatHapticFilename, loop: true)
    }
    @objc func wind() {
        Vibrator.shared.startVibrate(frequency: .high, loop: true)
    }
    @objc func volcano() {
        Vibrator.shared.startVibrate(loop: false)
    }
    @objc func landflake() {
        Vibrator.shared.startHaptic(named: PatternVC.heartbeatHapticFilename, loop: true)
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
    func fullscreenAds() {
        guard
            Appodeal.isInitalized(for: .interstitial),
            Appodeal.canShow(.interstitial, forPlacement: "")
        else {
            return
        }
        Appodeal.showAd(.interstitial,
                        forPlacement: "",
                        rootViewController: self)
    }
    func patternVibration(patternType:String) {
        switch patternType {
        case "Hurricane":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.hurricane), userInfo: nil, repeats: true)
            break
        case "Whirlpool":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.whirlpool), userInfo: nil, repeats: true)
            break
        case "Strom":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.storm), userInfo: nil, repeats: true)
            break
        case "Waterfall":
            Vibrator.shared.startHaptic(named: PatternVC.heartbeatHapticFilename, loop: true)
            break
        case "Explosion":
            self.vibrationTimer.invalidate()
            self.vibrationTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.explosion), userInfo: nil, repeats: true)
            break
        case "Balance":
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
        case "Fire":
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
            Vibrator.shared.startHaptic(named: PatternVC.heartbeatHapticFilename, loop: true)
            break
        default:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            break
        }
    }
    
    @IBAction func btnInputOutputAction(_ sender: UIButton) {
        if self.btnInputOutput.isSelected {
            self.isOnVibration = false
            self.vibrationTimer.invalidate()
            Vibrator.shared.stopHaptic()
            Vibrator.shared.stopVibrate()
            self.btnInputOutput.isSelected = false
            self.btnInputOutput.setTitle("I", for: UIControl.State.normal)
            self.btnInputOutput.backgroundColor = UIColor.init(red: 247.0/255.0, green: 137.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        } else {
            self.isOnVibration = true
            self.patternVibration(patternType: arrPatterns[selectedPattern])
            self.btnInputOutput.isSelected = true
            self.btnInputOutput.setTitle("O", for: UIControl.State.normal)
            self.btnInputOutput.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        }
    }
}
//Mark: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension PatternVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPatterns.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.clvPattern.dequeueReusableCell(withReuseIdentifier: "cellPattern", for: indexPath) as! cellPattern
        cell.lblPattern.text = arrPatterns[indexPath.row]
        cell.imgPattern.image = UIImage.init(named: arrPatternsImages[indexPath.row].lowercased())
        cell.bgView.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        cell.bgView.layer.borderWidth = 5.0
        cell.bgView.layer.cornerRadius = 15.0
        if self.arrSelection[indexPath.row] == 1 {
            cell.bgView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        } else {
            cell.bgView.backgroundColor = UIColor.clear
        }
        cell.vwLock.layer.cornerRadius = 15.0
        if indexPath.row < 3 {
            cell.vwLock.isHidden = true
        } else {
            cell.vwLock.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3) - 10.0, height: (collectionView.frame.size.width/3) - 10.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < 3 {
            if self.countThree == 3 {
                self.countThree = 0
                self.fullscreenAds()
            }
            self.countThree = self.countThree + 1
            self.selectedPattern = indexPath.row
            for i in 0 ..< self.arrSelection.count {
                self.arrSelection[i] = 0
            }
            self.arrSelection[indexPath.row] = 1
            self.clvPattern.reloadData()
            if self.previousSelectionIndex != indexPath.row {
                self.isOnVibration = true
                self.btnInputOutput.isSelected = false
                self.btnInputOutput.setTitle("O", for: UIControl.State.normal)
                self.btnInputOutput.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
                self.patternVibration(patternType: arrPatterns[indexPath.row])
            } else {
                if self.btnInputOutput.isSelected {
                    self.vibrationTimer.invalidate()
                    Vibrator.shared.stopHaptic()
                    Vibrator.shared.stopVibrate()
                    self.isOnVibration = false
                    self.btnInputOutput.isSelected = false
                    self.btnInputOutput.setTitle("I", for: UIControl.State.normal)
                    self.btnInputOutput.backgroundColor = UIColor.init(red: 247.0/255.0, green: 137.0/255.0, blue: 209.0/255.0, alpha: 1.0)
                } else {
                    self.isOnVibration = true
                    self.btnInputOutput.isSelected = true
                    self.btnInputOutput.setTitle("O", for: UIControl.State.normal)
                    self.btnInputOutput.backgroundColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0)
                    self.patternVibration(patternType: arrPatterns[indexPath.row])
                }
            }
            self.previousSelectionIndex = indexPath.row
            self.btnInputOutput.isSelected = true
        }
    }
}
