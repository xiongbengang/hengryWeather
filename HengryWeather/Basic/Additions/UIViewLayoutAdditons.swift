//
//  UIViewLayoutAdditons.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

public let navigationBarHeight: CGFloat = 44
public let tabbarHeight: CGFloat = 49

public func statusBarHeight() -> CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

public func navigationTopHeight() -> CGFloat {
    return statusBarHeight() + navigationBarHeight
}

public func tabbarBottomHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 + tabbarHeight
    } else {
        return tabbarHeight
    }
}

public var screenWidth: CGFloat = {
   return UIScreen.main.bounds.width
}()

public var screenHeight: CGFloat = {
    return UIScreen.main.bounds.height
}()

public var separatorSize: CGFloat = {
    return 1.0/UIScreen.main.scale
}()

extension UIView {
    public var left: CGFloat {
        get { return self.frame.minX }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    
    public var right: CGFloat {
        get { return self.frame.maxX }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin.x = right - newFrame.width
            self.frame = newFrame
        }
    }
    
    public var top: CGFloat {
        get { return self.frame.minY }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    
    public var bottom: CGFloat {
        get { return self.frame.maxY }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin.y = newValue - newFrame.height
            self.frame = newFrame
        }
    }
    
    public var centerX: CGFloat {
        get { return self.center.x }
        set(newValue) {
            var newCenter = self.center
            newCenter.x = newValue
            self.center = newCenter
        }
    }
    
    public var centerY: CGFloat {
        get { return self.center.y }
        set(newValue) {
            var newCenter = self.center
            newCenter.y = newValue
            self.center = newCenter
        }
    }
    
    public var size: CGSize {
        get { return self.frame.size }
        set(newValue) {
            var newFrame = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
    }
    
    public var width: CGFloat {
        get { return self.frame.width }
        set(newValue) {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    
    public var height: CGFloat {
        get { return self.size.height }
        set(newValue) {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    
    public var origin: CGPoint {
        get { return self.frame.origin }
        set(newValue) {
            var newFrame = self.frame
            newFrame.origin = newValue
            self.frame = newFrame
        }
    }
    
    public var adaptSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        }
        return UIEdgeInsets.zero
    }
}
