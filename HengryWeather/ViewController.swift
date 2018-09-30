//
//  ViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/3.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftyJSON
import CoreLocation
import ObjectMapper
import SnapKit

let networkActivityPlugin = NetworkActivityPlugin { (type, target) in
    switch type {
    case NetworkActivityChangeType.began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case NetworkActivityChangeType.ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

let loggerPlugin = NetworkLoggerPlugin(verbose: true)

class ViewController: UIViewController {
    
    var weatherTypeLabel: UILabel!
    var temperatureLabel: UILabel!
    var reportTime: UILabel!
    var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "天气预报"
        setupSubviews()
        self.loadDatas()
    }
    
    func setupSubviews() {
        let refreshBarItem = UIBarButtonItem(title: "刷新", style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshButtonClick))
        navigationItem.rightBarButtonItem = refreshBarItem
        
        cityLabel = UILabel(frame: CGRect.zero)
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(view).offset(20)
            maker.top.equalTo(view.snp.topMargin).offset(20)
        }
        
        weatherTypeLabel = UILabel(frame: CGRect.zero)
        weatherTypeLabel.textColor = UIColor.red
        weatherTypeLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(weatherTypeLabel)
        weatherTypeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.snp.topMargin).offset(80)
            maker.centerX.equalTo(view)
        }
        
        temperatureLabel = UILabel(frame: .zero)
        temperatureLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(weatherTypeLabel)
            maker.left.equalTo(weatherTypeLabel.snp.right).offset(30)
        }
        
        reportTime = UILabel(frame: CGRect.zero)
        view.addSubview(reportTime)
        reportTime.snp.makeConstraints { (maker) in
            maker.top.equalTo(weatherTypeLabel.snp.bottom).offset(50)
            maker.right.equalTo(view).offset(-20)
        }
        
        let bottomView = UIView()
        UIView.separatorColor = .orange
        bottomView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(200)
            make.top.equalTo(reportTime.snp.bottom).offset(30)
        }
        bottomView.addSeparator(at: UIView.SeparatorPostion.left, with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0))
    }
    
    func loadDatas() {
        let weatherApi = WeatherApi(baseURLString: "https://restapi.amap.com/",
                                           path: "v3/weather/weatherInfo",
                                           method: .get,
                                           urlParameters: ["key": "4d666b515b69193fc3b4d62cdec4bdc4", "city": "110101"],
                                           parsedClass: WeatherResponse.self)
        NetworkManager.shared.request(target: weatherApi, netwokHandler: self)
    }
    @IBAction func refreshButtonClick() {
        loadDatas()
    }
}

extension ViewController: NetworkHandler {
    
    func handleResponseSuccess(responseItem: ResponseItem) {
        let resp = responseItem.parsed as? WeatherResponse
        let firstLive = resp?.lives?.first
        let province = firstLive?.province
        let city = firstLive?.city
        self.cityLabel.text = "\(province ?? "")\(city ?? "")"
        self.weatherTypeLabel.text = firstLive?.weather
        self.temperatureLabel.text = firstLive?.temperature
        self.reportTime.text = firstLive?.reporttime
    }
    func handleResponseError(responseItem: ResponseItem) {
        
    }
    func handleResponseFailed(error:MoyaError) {
        
    }
}
