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
    
    public var urlString: String
    public var parameters: [String: Any]
    public var sourceController: UIViewController
    public var transationStyle: TransationStyle
    public var transationAnimated: Bool = true
    
    private var url: URL?
    
    public var identifier: String {
        if let host = self.url?.host {
            return host
        }
        return urlString.lowercased()
    }
    
    public var allParameters: [String: Any] {
        guard let url = self.url else {
            return self.parameters
        }
        return self.parameters.merging(url.queryParameters) { (_, new) -> Any in new }
    }
    
    public init(urlString:String,
                parameters: [String: Any] = [:],
                sourceController: UIViewController = UIViewController.topMost(),
                transationStyle: TransationStyle = .push) {
        self.urlString = urlString
        self.url = URL(string: urlString)
        self.parameters = parameters
        self.sourceController = sourceController
        self.transationStyle = transationStyle
    }
}

public protocol RouterHandler: AnyObject {
    
    func handleRequest(_ request: RouterRequest)
    
}

public protocol RouterResponsable {
    func config(with parameters: [String: Any])
}


public class Router {
    
    public static let ViewControllerTitleKey = "title"

    public static let shared: Router = {
        return Router()
    }()
    
    private var viewControllersMap: [String: UIViewController.Type] = [:]
    
    public func regist(_ urlString: String, controllerClass: UIViewController.Type) {
        viewControllersMap[urlString.lowercased()] = controllerClass
    }
    
    public func open(_ urlString: String,
                     from sourceController: UIViewController = UIViewController.topMost(),
                     parameters: [String: Any] = [:],
                     transationStyle: RouterRequest.TransationStyle = .push) {
        self.open(RouterRequest(urlString: urlString, parameters: parameters, sourceController: sourceController, transationStyle: transationStyle))
    }
    
    public func open(_ request:RouterRequest, customerHandler: RouterHandler? = nil) {
        if let handler = customerHandler {
            handler.handleRequest(request)
        } else {
            handleRequest(request)
        }
    }
    
    private func responseController(for request: RouterRequest) -> UIViewController? {
        guard let cls = viewControllersMap[request.identifier] else { return nil }
        let xibName = NSStringFromClass(cls).components(separatedBy: ".").last
        let xibPath = Bundle.main.path(forResource: xibName, ofType: "nib")
        let responseController: UIViewController
        if let xibPath = xibPath, FileManager.default.fileExists(atPath: xibPath) {
            responseController = cls.init(nibName: xibName, bundle: nil)
        } else {
            responseController = cls.init()
        }
        if let responseController = responseController as? RouterResponsable {
            responseController.config(with: request.allParameters)
        }
        return responseController
    }
    
    private func handleRequest(_ request: RouterRequest) {
        guard let responseController = responseController(for: request) else { return }
        if case .push = request.transationStyle {
            request.sourceController.navigationController?.pushViewController(responseController, animated: request.transationAnimated)
        } else if case .present(let completion) = request.transationStyle {
            request.sourceController.present(responseController, animated: request.transationAnimated, completion: completion)
        }
    }
}
