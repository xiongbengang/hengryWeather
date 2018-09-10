//
//  MainTabbarViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/23.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        
    }

    func setupControllers() {
        let homeViewController = UINavigationController(rootViewController: ViewController())
        let discoveryViewController = UINavigationController(rootViewController: DiscoverViewController())
        let meViewController = UINavigationController(rootViewController: MeViewController())
        self.viewControllers = [homeViewController, discoveryViewController, meViewController]
    }

}
