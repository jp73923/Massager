//
//  MusicVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit
import PanModal
import AVFoundation

class cellMusic:UITableViewCell {
    @IBOutlet weak var lblMusic: UILabel!
    @IBOutlet weak var imgMusic: UIImageView!
    @IBOutlet weak var bgView: UIView!
}
class MusicVC: UIViewController {
    @IBOutlet weak var tblMusic: UITableView!
    
    var isShortFormEnabled = true
    var player: AVAudioPlayer?

    var arrIcons = ["no_music","dove","danger","rain","waterfall","wave"]
    var arrLabels = ["NO","BIRDS","FIRE","RAIN","RAIN 2","SEA"]
    var arrSounds = ["NO","birds","fire","rain","rain2","sea"]
    var arrSoundsExtension = ["NO","wav","mp3","wav","mp3","mp3"]

    var arrSelection = [0,0,0,0,0,0]

    override func viewDidLoad() {
        super.viewDidLoad()
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

//MARK: - UITableview Delegate Methods
extension MusicVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblMusic.dequeueReusableCell(withIdentifier: "cellMusic", for: indexPath) as! cellMusic
        cell.lblMusic.text = self.arrLabels[indexPath.row].localiz()
        cell.imgMusic.image = UIImage.init(named: self.arrIcons[indexPath.row])
        if self.arrSelection[indexPath.row] == 1 {
            cell.bgView.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 0.0/255.0, blue: 218.0/255.0, alpha: 1.0).cgColor
        } else {
            cell.bgView.layer.borderColor = UIColor.clear.cgColor
        }
        cell.bgView.layer.borderWidth = 5.0
        cell.bgView.layer.cornerRadius = 15.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0 ..< self.arrSelection.count {
            self.arrSelection[i] = 0
        }
        self.playSound(soundName: self.arrSounds[indexPath.row], soundExtension: arrSoundsExtension[indexPath.row])
        self.arrSelection[indexPath.row] = 1
        APP_DELEGATE.musicSelected = self.arrSounds[indexPath.row]
        APP_DELEGATE.musicExtensionSelected = arrSoundsExtension[indexPath.row]
        self.tblMusic.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}


//MARK: - PanModalPresentable
extension MusicVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return self.tblMusic
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset((UIScreen.main.bounds.size.height/2) - 200.0)
    }
    var shortFormHeight: PanModalHeight {
        return isShortFormEnabled ? .contentHeight(500.0) : longFormHeight
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    var showDragIndicator: Bool{
        return false
    }
    var allowsExtendedPanScrolling: Bool { return true }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard isShortFormEnabled, case .longForm = state else { return }
        isShortFormEnabled = false
        panModalSetNeedsLayoutUpdate()
    }
}
