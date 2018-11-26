//
//  NetworkManager.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/23.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import Moya
import Result
import ObjectMapper
import SwiftyJSON

public protocol ResponseParsable {
    init(_ response: Moya.Response)
}

public protocol NetworkTargetType: TargetType {
    associatedtype ResponseItem: ResponseParsable
    
    typealias SuccessCallback = (ResponseItem?) -> ()
    typealias FailureCallback = (MoyaError) -> ()
    
    var plugins: [PluginType] { get }
}

public protocol NetworkHandlable {
    func handleSuccess(responseItem: ResponseParsable)
    func handleFailure(error:MoyaError)
}

extension NetworkHandlable {
    func handleSuccess(responseItem: ResponseParsable) {}
    func handleFailure(error:MoyaError) {}
}

public protocol NetworkClient {
    func sendRequest<T: NetworkTargetType>(target: T, success: T.SuccessCallback?, failure: T.FailureCallback?, customHandler: NetworkHandlable?)
}

public final class CommonNetworkClient: NetworkClient {
    public func sendRequest<T: NetworkTargetType>(target: T,
                                                  success: T.SuccessCallback? = nil,
                                                  failure: T.FailureCallback? = nil,
                                                  customHandler: NetworkHandlable? = nil) {
        
        var plugins = NetworkConfig.default.defaultPlugins
        plugins.append(contentsOf: target.plugins)
        let provider = MoyaProvider<T>(plugins: plugins)
        provider.request(target) { (result: Result<Response, MoyaError>) in
            switch result {
            case let Result.success(response):
                let parsed = T.ResponseItem.init(response)
                if let success = success {
                    success(parsed)
                }
                if let customHandler = customHandler {
                    customHandler.handleSuccess(responseItem: parsed)
                }
            case let Result.failure(error):
                if let failure = failure {
                    failure(error)
                }
                if let customHandler = customHandler {
                    customHandler.handleFailure(error: error)
                }
            }
        }
    }
    public static let shared: CommonNetworkClient = {
        return CommonNetworkClient()
    }()
}




