//
//  Network.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/22.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case get
    case post
}

protocol Decodable {
    static func parse(data: Data) -> Self?
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    associatedtype Response: Decodable
}
protocol Client {
    func send<T: Request>(_ request: T, handler: @escaping (T.Response?) -> Void)
    var host: String { get }
}


struct URLSessionClient: Client {
    var host: String
    func send<T: Request>(_ rq: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(rq.path))!
        var request = URLRequest(url: url)
        request.httpMethod = rq.method.rawValue
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
        }
        task.resume()
    }
}
