//
//  NetworkConfig.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/20.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import Moya

public class NetworkConfig {
    
    var baseURLString:String?
    var defaultMethod: Moya.Method = .post
    
    public static let shared: NetworkConfig = {
        return NetworkConfig()
    }()
}
