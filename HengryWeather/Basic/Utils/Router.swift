//
//  Router.swift
//  HengryWeather
//
//  Created by bengang on 2018/9/23.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import UIKit

extension URL {
    public var queryParameters: [String: String] {
        var parameters: [String: String] = [:]
        guard let components = URLComponents(string: self.absoluteString),
            let queryItems = components.queryItems else {
                return parameters
        }
        for queryItem:URLQueryItem in queryItems {
            parameters.updateValue(queryItem.value!, forKey: queryItem.name)
        }
        return parameters
    }
}

public class RouterRequest {
    
    public typealias TransationFinished = ()->()
    public enum TransationStyle {
        case push
        case present(TransationFinished?)
    }
    
    public var url: URL
    public var parameters: [String: Any]
    public var sourceController: UIViewController
    public var transationStyle: TransationStyle
    public var transationAnimated: Bool = true
    
    public var urlHost: String? {
        return url.host
    }
    
    public var allParameters: [String: Any] {
        let merged = self.parameters.merging(url.queryParameters) { (_, new) -> Any in
            return new
        }
        return merged
    }
    
    public init(url: URL, parameters: [String: Any],
                sourceController: UIViewController = UIViewController.topMost(),
                transationStyle: TransationStyle = .push) {
        self.url = url
        self.parameters = parameters
        self.sourceController = sourceController
        self.transationStyle = transationStyle
    }
    
    public convenience init(urlString:String,
                            parameters: [String: Any] = [:],
                            sourceController: UIViewController = UIViewController.topMost(),
                            transationStyle: TransationStyle = .push) {
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        self.init(url: url, parameters: parameters)
    }
}

public protocol RouterHandler: AnyObject {
    
    func handleRequest(_ request: RouterRequest)
    
    func responseController(for routerRequest: RouterRequest) -> UIViewController?
}


public class BaseRouterHandler: RouterHandler {
    
    public func handleRequest(_ request: RouterRequest) {
        guard let responseController = self .responseController(for: request) else { return }
        if case .push = request.transationStyle {
            request.sourceController.navigationController?.pushViewController(responseController, animated: request.transationAnimated)
        } else if case .present(let completion) = request.transationStyle {
            request.sourceController.present(responseController, animated: request.transationAnimated, completion: completion)
        }
    }
    
    public func responseController(for routerRequest: RouterRequest) -> UIViewController? {
        return nil
    }
}

public class Router {
    
    public static let router: Router = {
        return Router()
    }()
    
    public init() {
    
    }
    
    private var handlerClassMapping: [String: RouterHandler.Type] = [:]
    private func routerHandler(for request: RouterRequest) -> RouterHandler {
        let handler = BaseRouterHandler()
        guard let host = request.urlHost else { return handler}
        let handlerClass = self.handlerClassMapping[host]
        return handler
    }
    
    public func regist(_ urlString: String, handlerClass: RouterHandler.Type) {
        self.handlerClassMapping[urlString] = handlerClass
    }
    
    public func open(_ request:RouterRequest, sourceController: UIViewController = UIViewController.topMost(), parameters: [String: Any] = [:], customerHandler: RouterHandler?) {
        if let handler = customerHandler {
            handler.handleRequest(request)
        } else {
            BaseRouterHandler().handleRequest(request)
        }
        self.regist("aaa", handlerClass: BaseRouterHandler.self)
    }
}
