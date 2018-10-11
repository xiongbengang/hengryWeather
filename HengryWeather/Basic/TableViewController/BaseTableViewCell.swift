//
//  BaseTableViewCell.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    
    open var topSeparator: UIView!
    open var bottomSeparator: UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubviews()
    }
    
    open func setupSubviews() {
        topSeparator = UIView()
        addSubview(topSeparator)
        bottomSeparator = UIView()
        addSubview(bottomSeparator)
    }
    
    open func bind(data: Any) {
        guard let cellItem = data as? CellItem else {
            return
        }
        if cellItem.showArrow {
            self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        self.textLabel?.text = cellItem.name
    }
}
