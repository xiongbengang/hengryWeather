//
//  BaseTableViewCell.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

public class BaseTableViewCell: UITableViewCell {
    
    public var topSeparator: UIView!
    public var bottomSeparator: UIView!
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubviews()
    }
    
    public func setupSubviews() {
        topSeparator = UIView()
        addSubview(topSeparator)
        bottomSeparator = UIView()
        addSubview(bottomSeparator)
    }
    
    public func bind(data: Any) {
        guard let cellItem = data as? CellItem else {
            return
        }
        if cellItem.showArrow {
            self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        self.textLabel?.text = cellItem.name
    }
}
