//
//  MeViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/22.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit

class MeViewController: BaseTableViewController {

    private var settingItem: CellItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        prepareAndReloadDatas()
    }
    
    override var tableViewStyle: UITableView.Style {
        return .grouped
    }
    
    func prepareAndReloadDatas() {
        let cellItem1 = CellItem()
        cellItem1.name = "版本号"
        cellItem1.showArrow = true
        let cellItem2 = CellItem()
        cellItem2.name = "版本升级"
        cellItem2.showArrow = true
        let cellItem3 = CellItem()
        cellItem3.name = "设置"
        cellItem3.showArrow = true
        settingItem = cellItem3
        
        let section1 = TableSection(items: [cellItem1, cellItem2, cellItem3])
        section1.headerHeight = 0
        section1.footerHeight = 0.1
        self.sections = [section1]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if settingItem === cellItemAt(indexPath) {
            let settingPath = "Settings"
            Router.shared.open(settingPath, from: self, parameters: [Router.ViewControllerTitleKey: "设置"])
        }
    }
}
