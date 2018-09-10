//
//  WeatherApi.swift
//  HengryWeather
//
//  Created by CC on 2018/8/25.
//  Copyright © 2018年 puerjia. All rights reserved.
//

import Foundation

class WeatherApi: BaseNetworkTarget {
    override var isResponseSuccess: ResponseSuccessValidator? {
        return { (responseItem) -> Bool in
            return responseItem.code == 1
        }
    }
}
