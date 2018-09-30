//
//  UIImageAdditions.swift
//  HengryWeather
//
//  Created by bengang on 2018/9/22.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    public func apply(cornerRadius:CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0)
        let rect = CGRect(origin: .zero, size: self.size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func stretchCenter() -> UIImage {
        let top = self.size.height * 0.5
        let left = self.size.width * 0.5
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: top, left: left, bottom: top-0.5, right: left-0.5))
    }
}
