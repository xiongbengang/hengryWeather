//
//  Alert.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/26.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func alert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        topMost().present(alertController, animated: true, completion: nil)
    }
}
