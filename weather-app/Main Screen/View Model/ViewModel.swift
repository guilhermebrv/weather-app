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
    
    public func checkWeatherCondition(id: Int) -> String {
        switch id {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "clod.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...899:
            return "cloud"
        default:
            return "cloud"
        }
    }

    public func fetchDataFromService(cityname: String) {
        weatherService.fetchWeather(cityName: cityname) { data, error in
            if error == nil {
                self.weatherData = data
                self.delegate?.successFetchingData()
                print(self.weatherData?.name ?? "")
            } else {
                self.delegate?.errorFetchingData()
                print("error")
            }
        }
    }
    
}
