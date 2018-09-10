//
//  UIViewSeparatorAdditons.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

extension UIView {
    public static var separatorColor: UIColor = UIColor.lightGray
    
    public enum SeparatorPostion {
        case top
        case bottom
        case left
        case right
    }
    
    @discardableResult
    public func addSeparator(at postion:SeparatorPostion, with insets: UIEdgeInsets = UIEdgeInsets.zero) -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIView.separatorColor
        addSubview(separator)
        separator.snp.makeConstraints { (maker) in
            switch postion {
            case .top:
                maker.height.equalTo(separatorSize)
                maker.left.equalTo(self).offset(insets.left)
                maker.right.equalTo(self).offset(-insets.right)
                maker.top.equalTo(self).offset(insets.top)
            case .bottom:
                maker.height.equalTo(separatorSize)
                maker.left.equalTo(self).offset(insets.left)
                maker.right.equalTo(self).offset(-insets.right)
                maker.bottom.equalTo(self).offset(-insets.bottom)
            case .left:
                maker.width.equalTo(separatorSize)
                maker.left.equalTo(self).offset(insets.left)
                maker.top.equalTo(self).offset(insets.top)
                maker.bottom.equalTo(self).offset(-insets.bottom)
            case .right:
                maker.width.equalTo(separatorSize)
                maker.right.equalTo(self).offset(-insets.right)
                maker.top.equalTo(self).offset(insets.top)
                maker.bottom.equalTo(self).offset(-insets.bottom)
            }
        }
        return separator
    }
    
    public func remakeLeftConstraint(_ constraint: CGFloat) {
        self.snp.remakeConstraints { (maker) in
            maker.left.equalTo(self.superview!).offset(constraint)
        }
    }
    
    public func remakeRightConstraint(_ constraint: CGFloat) {
        self.snp.remakeConstraints { (maker) in
            maker.right.equalTo(self.superview!).offset(-constraint)
        }
    }
    
    public func remakeTopConstraint(_ constraint: CGFloat) {
        self.snp.remakeConstraints { (maker) in
            maker.top.equalTo(self.superview!).offset(constraint)
        }
    }
    
    public func remakeBottomConstraint(_ constraint: CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.superview!).offset(-constraint)
        }
    }
}
