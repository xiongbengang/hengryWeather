//
//  TopMostViewController.swift
//  HengryWeather
//
//  Created by bengang on 2018/9/23.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit


extension UIViewController {
    
    public class func topMost() -> UIViewController {
        let window = UIApplication.shared.delegate?.window
        var topMostController:UIViewController? = window??.rootViewController
        while true {
            if topMostController?.presentedViewController != nil {
                topMostController = topMostController?.presentedViewController
            } else if let navigationController = topMostController as? UINavigationController {
                topMostController = navigationController.visibleViewController
            } else if let tabbarController = topMostController as? UITabBarController {
                topMostController = tabbarController.selectedViewController
            } else {
                break
            }
        }
        return topMostController!  // topmostViewController could not be nil
    }
}
