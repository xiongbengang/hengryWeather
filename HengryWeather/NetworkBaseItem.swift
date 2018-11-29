//
//  NetworkBaseItem.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/25.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

open class NetworkBaseItem: ResponseParsable {
    
    public var rawJSON: JSON?
    public var code: Int = 0
    public var message: String = ""
    public var rawResponse: Response
    required public init(_ response: Response) {
        self.rawResponse = response
        if let jsonObj = try? response.mapJSON() {
            self.rawJSON = JSON(jsonObj)
        }
        guard let json = rawJSON else { return }
        self.code = json["code"].intValue
        self.message = json["message"].stringValue
    }
}
