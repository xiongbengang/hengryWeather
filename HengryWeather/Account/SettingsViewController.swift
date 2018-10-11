//
//  SettingsViewController.swift
//  HengryWeather
//
//  Created by bengang on 2018/10/8.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, RouterResponsable {
    func config(with parameters: [String : Any]) {
        self.title = parameters[Router.ViewControllerTitleKey] as? String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}
