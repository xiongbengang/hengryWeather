//
//  Model.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

open class CellItem {
    open var cellHeight: CGFloat?
    open var name: String?
    open var showArrow: Bool = false
}

open class TableSection {
    open var headerHeight: CGFloat = 0.1
    open var footerHeight: CGFloat = 0.1
    open var items: [CellItem]
    public init(items: [CellItem]) {
        self.items = items
    }
    public convenience init() {
        self.init(items: [])
    }
}
