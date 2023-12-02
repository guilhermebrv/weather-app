//
//  ViewModel.swift
//  weather-app
//
//  Created by Guilherme Viana on 30/11/2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    func successFetchingData()
    func errorFetchingData()
}

class ViewModel {
    
    public var weatherData: WeatherData?
    private var weatherService: WeatherService = WeatherService()
    private weak var delegate: ViewModelProtocol?
    public func delegate(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }

    public func fetchDataFromService(cityname: String) {
        weatherService.fetchWeather(cityName: cityname) { data, error in
            if error == nil {
                self.weatherData = data
                self.delegate?.successFetchingData()
            } else {
                self.delegate?.errorFetchingData()
            }
        }
    }
    
}
