//
//  BaseNetworkItem.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/24.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import Moya

open class BaseRequest<T>: NetworkTargetType where T: ResponseParsable {
    public enum EncodingType {
        case http
        case json
    }
    public typealias ResponseItem = T
    
    init(path: String,
         bodyParameters: [String: Any] = [:],
         urlParameters:[String: Any] = [:]) {
        self.path = path
        self.bodyParameters = bodyParameters
        self.urlParameters = urlParameters
    }
    
    open var baseURLString: String?
    open var path: String
    open var plugins: [PluginType] = []
    open var bodyParameters: [String: Any]
    open var urlParameters: [String: Any]
    open var encodingType: EncodingType = .json
    open var headers: [String : String]?
    
    open var baseURL: URL {
        if let baseURLString = baseURLString {
            if let url = URL(string: baseURLString) {
                return url
            } else {
               fatalError("baseURLString is not a valid url!")
            }
        } else {
            if let urlString = NetworkConfig.default.baseURLString, let url = URL(string: urlString) {
                return url
            } else {
                return URL(string: path)!
            }
        }
    }
    
    open var method: Moya.Method = NetworkConfig.default.defaultMethod
    
    open var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    open var task: Task {
        switch encodingType {
        case .http:
            return Task.requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: URLEncoding.httpBody, urlParameters: urlParameters)
        case .json:
            return Task.requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        }
    }
}
