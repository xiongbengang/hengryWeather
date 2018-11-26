//
//  NetworkConfig.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/20.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import Moya

extension NetworkActivityPlugin {
    
    public class func `default`() -> NetworkActivityPlugin {
        let networkActivityPlugin = NetworkActivityPlugin { (type, target) in
            switch type {
            case NetworkActivityChangeType.began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case NetworkActivityChangeType.ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        return networkActivityPlugin
    }
}

public final class NetworkConfig {
    
    public var baseURLString:String?
    public var defaultMethod:Moya.Method = .post
    public var defaultPlugins:[PluginType] = []
    
    private init() {
        self.defaultPlugins = [NetworkActivityPlugin.default(), NetworkLoggerPlugin(verbose: true)]
    }
    
    public static let `default`: NetworkConfig = {
        return NetworkConfig()
    }()
}
