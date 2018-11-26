//
//  BaseViewController.swift
//  HengryWeather
//
//  Created by bengang on 2018/10/5.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, RouterResponsable {

    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open func config(with parameters: [String : Any]) {
        self.title = parameters[Router.Key.title.rawValue] as? String
    }
    
    open func back() {
        if let count = navigationController?.viewControllers.count, count > 1 {
            navigationController?.popViewController(animated: true)
        } else if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
