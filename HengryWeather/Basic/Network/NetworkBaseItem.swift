//
//  NetworkBaseItem.swift
//  HengryWeather
//
//  Created by bengang on 2018/11/25.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Moya

open class NetworkBaseItem: ResponseParsable {
    public var rawJSON: JSON?
    public required init(_ response: Response) {
        if let jsonObject = try? response.mapJSON() {
            self.rawJSON = JSON(jsonObject)
        }
    }
}
