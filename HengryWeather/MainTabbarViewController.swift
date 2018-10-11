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
        setupAppearence()
    }
    
    func setupControllers() {
        let homeViewController = BaseNavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.title = "天气预报"
        homeViewController.tabBarItem.image = UIImage(named: "icon_home_tabbar")
        let discoveryViewController = BaseNavigationController(rootViewController: DiscoverViewController())
        discoveryViewController.tabBarItem.title = "发现"
        discoveryViewController.tabBarItem.image = UIImage(named: "icon_location_tabbarwhite")
        let meViewController = BaseNavigationController(rootViewController: MeViewController())
        meViewController.tabBarItem.image = UIImage(named: "icon_my_tabbarwhite")
        meViewController.tabBarItem.title = "我的"
        self.viewControllers = [homeViewController, discoveryViewController, meViewController]
    }
    
    func setupAppearence() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = .black
        var textAttributes: [NSAttributedString.Key: AnyObject] = [:]
        textAttributes[.foregroundColor] = UIColor.black
        textAttributes[.font] = UIFont.systemFont(ofSize: 20)
        navigationBar.titleTextAttributes = textAttributes
        
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .black
    }
    
}
