//
//  LockVC.swift
//  Massager
//
//  Created by Jay on 26/05/22.
//

import UIKit

class LockVC: UIViewController {
    
    @IBOutlet weak var btnLockHold: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let longpressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tapped))
        self.btnLockHold.addGestureRecognizer(longpressGestureRecognizer)
    }
    @objc func tapped(sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }

}
