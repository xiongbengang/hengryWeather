//
//  WeatherResponse.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/12.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import Moya

public class WeatherResponse: NetworkBaseItem {
    public var weather: Weather?
    public required init(_ response: Response) {
        self.weather = try? response.map(Weather.self)
        super.init(response)
    }
}

public class Weather: Codable {
    public var count: String?
    public var info: String?
    public var infocode: String?
    public var status: String?
    public var lives: [Lives]?
    enum CodingKeys:String, CodingKey {
        case count, info, infocode, status, lives
    }
}

public class Lives: Codable {
    public var adcode:String?
    public var city:String?
    public var humidity:String?
    public var province:String?
    public var reporttime:String?
    public var temperature:String?
    public var weather:String?
    public var winddirection:String?
    public var windpower:String?
    
    enum CodingKeys:String, CodingKey {
        case adcode, city, humidity, province, reporttime, temperature, weather, winddirection, windpower
    }
}
