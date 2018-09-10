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
import SwiftyJSON
import ObjectMapper

public typealias ResponseSuccessValidator = (ResponseItem) -> Bool

public class ResponseItem {
    public var code = 0
    public var message:String = ""
    public var original:JSON?
    public var parsed:Mappable?
}

public protocol NetworkTargetType: TargetType {
    var parsedClass: Mappable.Type? { get }
    var isResponseSuccess: ResponseSuccessValidator? { get }
}

extension NetworkTargetType {
    public var isResponseSuccess: ResponseSuccessValidator? { return nil }
}

public protocol NetworkHandler {
    func handleResponseSuccess(responseItem: ResponseItem)
    func handleResponseError(responseItem: ResponseItem)
    func handleResponseFailed(error:MoyaError)
    var isResponseSuccess: ResponseSuccessValidator? { get }
}

extension NetworkHandler {
    
    func handleResponseSuccess(responseItem: ResponseItem) {
        
    }
    func handleResponseError(responseItem: ResponseItem) {
        
    }
    func handleResponseFailed(error:MoyaError) {
        
    }
    var isResponseSuccess: ResponseSuccessValidator? { return nil }
}

public class NetworkManager {
    public static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    let networkActivityPlugin = NetworkActivityPlugin { (type, target) in
        switch type {
        case NetworkActivityChangeType.began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
        case NetworkActivityChangeType.ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    let loggerPlugin = NetworkLoggerPlugin(verbose: true)
    
    public func request<T: NetworkTargetType>(target: T, netwokHandler:NetworkHandler?) {
        let provider = MoyaProvider<T>(plugins: [loggerPlugin, networkActivityPlugin])
        provider.request(target) { (result: Result) in
            switch result {
            case let Result.success(response):
                let responseItem = self.parseResponse(response, for: target)
                self.handleRequestSuccess(with: target, response: responseItem, networkHandler: netwokHandler)
            case let Result.failure(error):
                self.handleRequestFailed(with: error, networkHandler: netwokHandler)
            }
        }
    }
    
    func parseResponse(_ response:Response, for target:NetworkTargetType) -> ResponseItem {
        let responseItem = ResponseItem()
        let rawJSON = try? response.mapJSON(failsOnEmptyData: false)
        if let rawJSON = rawJSON {
            let wrapperJSON = JSON(rawValue: rawJSON)
            responseItem.original = wrapperJSON
            let status = wrapperJSON?["status"].intValue
            let message = wrapperJSON?["info"].stringValue
            if let status = status {
                responseItem.code =  status
            }
            if let message = message {
                responseItem.message = message
            }
        }
        if let parsedClass = target.parsedClass, let rawJSON = rawJSON as? [String: Any] {
            responseItem.parsed = parsedClass.init(JSON: rawJSON)
        }
        return responseItem
    }
    
    func handleRequestSuccess(with target:NetworkTargetType, response:ResponseItem, networkHandler: NetworkHandler?) {
        guard let networkHandler = networkHandler else {
            return;
        }
        let isResponseSuccessValidator = networkHandler.isResponseSuccess ?? target.isResponseSuccess
        var responseSuccess = true
        if let validator = isResponseSuccessValidator {
            responseSuccess = validator(response)
        }
        if responseSuccess {
            networkHandler.handleResponseSuccess(responseItem: response)
        } else {
            networkHandler.handleResponseError(responseItem: response)
        }
    }
    
    func handleRequestFailed(with error:MoyaError, networkHandler:NetworkHandler?) {
        guard let networkHandler = networkHandler else {
            return;
        }
        networkHandler.handleResponseFailed(error: error)
    }
}
