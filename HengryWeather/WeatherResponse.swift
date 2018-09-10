//
//  WeatherResponse.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/12.
//  Copyright © 2018 puerjia. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherResponse : Codable, Mappable {
    public var count: String?
    public var info: String?
    public var infocode: String?
    public var status: String?
    public var lives: [Lives]?

    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        self.count <- map["count"]
        self.info <- map["info"]
        self.infocode <- map["infocode"]
        self.status <- map["status"]
        self.lives <- map["lives"]
    }
}

class Lives: Codable, Mappable {
    
    enum LiveProperties:String {
        case adcode
        case city
        case humidity
        case province
        case reporttime
        case temperature
        case weather
        case winddirection
        case windpower
    }
    
    public var adcode:String?
    public var city:String?
    public var humidity:String?
    public var province:String?
    public var reporttime:String?
    public var temperature:String?
    public var weather:String?
    public var winddirection:String?
    public var windpower:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.adcode <- map[LiveProperties.adcode.rawValue]
        self.city <- map[LiveProperties.city.rawValue]
        self.humidity <- map[LiveProperties.humidity.rawValue]
        self.province <- map[LiveProperties.province.rawValue]
        self.reporttime <- map[LiveProperties.reporttime.rawValue]
        self.temperature <- map[LiveProperties.temperature.rawValue]
        self.weather <- map[LiveProperties.weather.rawValue]
        self.winddirection <- map[LiveProperties.winddirection.rawValue]
        self.windpower <- map[LiveProperties.windpower.rawValue]
    }
}
