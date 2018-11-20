//
//  BaseNetworkTarget.swift
//  HengryWeather
//
//  Created by CC on 2018/8/25.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class NetworkBaseRequest: NetworkTargetType {
    
    var parsedClass: Mappable.Type?
    
    var baseURLString:String
    
    var baseURL: URL {
        
        if baseURLString.isEmpty, let configBaseURLString = NetworkConfig.shared.baseURLString {
            baseURLString = configBaseURLString
        }

        guard let url = URL(string: baseURLString) else {
            fatalError("URLString must is a url")
        }
        return url
    }
    
    var path: String
    
    var method: Moya.Method
    
    var sampleData: Data = "".data(using: .utf8)!
    
    var bodyParameters: [String: Any]
    
    var urlParameters: [String: Any]
    
    var task: Task {
        return Task.requestCompositeParameters(bodyParameters: self.bodyParameters, bodyEncoding: URLEncoding.httpBody, urlParameters: self.urlParameters)
    }
    
    var headers: [String : String]?
    
    var isResponseSuccess: ResponseSuccessValidator? {
        return { (responseItem) -> Bool in
            return responseItem.code == 0
        }
    }
    
    init(baseURLString:String = "",
         path:String = "",
         method:Moya.Method = .post,
         bodyParameters: [String: Any] = [:],
         urlParameters: [String: Any] = [:],
         parsedClass: Mappable.Type? = nil) {
        self.baseURLString = baseURLString
        self.path = path
        self.method = method
        self.bodyParameters = bodyParameters
        self.urlParameters = urlParameters
        self.parsedClass = parsedClass
    }
}
