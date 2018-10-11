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
    
    public func config(with parameters: [String : Any]) {
        self.title = parameters[Router.ViewControllerTitleKey] as? String
    }
}
