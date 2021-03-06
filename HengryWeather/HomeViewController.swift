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

class HomeViewController: BaseViewController {
    
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
        let request = BaseRequest<WeatherResponse>(path: "v3/weather/weatherInfo", urlParameters: ["key": "4d666b515b69193fc3b4d62cdec4bdc4", "city": "110101"])
        request.method = .get
        request.encodingType = .http
        request.baseURLString = "https://restapi.amap.com/"
        CommonNetworkClient.shared.sendRequest(target: request, success: { (responseItem) in
            let firstLive = responseItem?.weather?.lives?.first
            let province = firstLive?.province ?? ""
            let city = firstLive?.city ?? ""
            self.title = province + city
            self.weatherTypeLabel.text = firstLive?.weather
            self.temperatureLabel.text = "\(firstLive?.temperature ?? "") C”"
        }, failure: { (error) in
            
        }, customHandler: nil)
    
        
    }
    @IBAction func refreshButtonClick() {
        loadDatas()
    }
}
