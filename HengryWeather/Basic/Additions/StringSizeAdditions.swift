//
//  StringAdditions.swift
//  HengryWeather
//
//  Created by CC on 2018/8/26.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

extension String {
    public func height(with font: UIFont, width: CGFloat) -> CGFloat {
        return self.size(with: font, constrainted: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    public func size(with font: UIFont,
                     constrainted: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                     lineBreakMode: NSLineBreakMode = .byWordWrapping,
                     lineSpacing: CGFloat = -1) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = max(0, lineSpacing)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        return self.size(with: attributes, constrainted: constrainted)
    }
    
    public func size(with attribute:[NSAttributedString.Key: Any], constrainted: CGSize) -> CGSize {
        let stringText = self as NSString
        let rect = stringText.boundingRect(with: constrainted, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute, context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }
}

