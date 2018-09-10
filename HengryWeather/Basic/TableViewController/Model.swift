//
//  Model.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

public class CellItem {
    public var cellHeight: CGFloat?
    public var name: String?
    public var showArrow: Bool = false
}

public class TableSection {
    public var headerHeight: CGFloat = 0
    public var footerHeight: CGFloat = 0
    public var items: [CellItem]
    public init(items: [CellItem]) {
        self.items = items
    }
    public convenience init() {
        self.init(items: [])
    }
}
