//
//  MeViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/22.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit

class MeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        prepareAndReloadDatas()
    }
    
    func prepareAndReloadDatas() {
        let cellItem1 = CellItem()
        cellItem1.name = "版本号"
        cellItem1.showArrow = true
        let cellItem2 = CellItem()
        cellItem2.name = "版本升级"
        cellItem2.showArrow = true
        let cellItem3 = CellItem()
        cellItem3.name = "good job"
        cellItem3.showArrow = true
        let section1 = TableSection(items: [cellItem1, cellItem2, cellItem3])
        self.sections = [section1]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
