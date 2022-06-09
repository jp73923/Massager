//
//  ViewController.swift
//  elasticOnboard
//
//  Created by Anton Skopin on 28/12/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit
import liquid_swipe

class ColoredController: UIViewController {
    var viewColor: UIColor = .white {
        didSet {
            viewIfLoaded?.backgroundColor = viewColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewColor
    }
}

class ViewController: LiquidSwipeContainerController, LiquidSwipeContainerDataSource {
    
    var viewControllers: [UIViewController] = {
        let firstPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page1")
        let secondPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page2")
        let thirdPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "page3")
        var controllers: [UIViewController] = [firstPageVC, secondPageVC, thirdPageVC]
        let vcColors: [UIColor] = []
        controllers.append(contentsOf: vcColors.map {
            let vc = ColoredController()
            vc.viewColor = $0
            return vc
        })
        return controllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = self
    }

    func numberOfControllersInLiquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController) -> Int {
        return viewControllers.count
    }
    
    func liquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }

}

