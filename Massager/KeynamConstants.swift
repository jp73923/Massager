//
//  KeynamConstants.swift
//  Massager
//
//  Created by Jay on 01/06/22.
//

import Foundation
import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

//MARK:- STORY BOARD NAMES
public let SB_MAIN :String = "Main"

//MARK:- CONTROLLERS ID
public let idCustomTabbarVC   = "CustomTabbarVC"


public func getStoryboard(storyboardName: String) -> UIStoryboard {
    return UIStoryboard(name: storyboardName, bundle: nil)
}

public func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
    let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
    return vc
}
