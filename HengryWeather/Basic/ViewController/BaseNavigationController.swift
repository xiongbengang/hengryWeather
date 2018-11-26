//
//  BaseNavigationController.swift
//  HengryWeather
//
//  Created by bengang on 2018/10/5.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}


