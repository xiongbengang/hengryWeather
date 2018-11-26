//
//  BaseTableViewCell.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit
import SnapKit

open class BaseTableViewCell: UITableViewCell {
    
    open var uiData: Any?
    open var topSeparator: UIView!
    open var bottomSeparator: UIView!
    open var customSeparatorInset: UIEdgeInsets = .zero
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubviews()
    }
    
    open func setupSubviews() {
        topSeparator = UIView(frame: .zero)
        topSeparator.isHidden = true
        addSubview(topSeparator)
        topSeparator.snp.makeConstraints { (maker) in
            maker.left.equalTo(self).offset(self.customSeparatorInset.left)
            maker.right.equalTo(self).offset(-self.customSeparatorInset.right)
            maker.top.equalTo(self)
            maker.height.equalTo(1.0/UIScreen.main.scale)
        }
        
        bottomSeparator = UIView(frame: .zero)
        bottomSeparator.isHidden = true
        addSubview(bottomSeparator)
        bottomSeparator.snp.makeConstraints { (maker) in
            maker.left.equalTo(self).offset(self.customSeparatorInset.left)
            maker.right.equalTo(self).offset(-self.customSeparatorInset.right)
            maker.bottom.equalTo(self)
            maker.height.equalTo(1.0/UIScreen.main.scale)
        }
    }
    
    open func bind(data: Any) {
        self.uiData = data
        if let cellItem = data as? CellItem {
            if cellItem.showArrow {
                self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }
            self.textLabel?.text = cellItem.name
        }
    }
    
    open func refresh() {
        guard let uidata = uiData else { return }
        bind(data: uidata)
    }
}
