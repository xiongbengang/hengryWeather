//
//  UIDeviceAdditions.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isIphoneX() -> Bool {
        if case .phone = self.userInterfaceIdiom, UIScreen.main.nativeBounds.height == 2436 {
            return true
        }
        return false
    }
}
