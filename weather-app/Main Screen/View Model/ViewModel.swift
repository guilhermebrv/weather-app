//
//  ViewModel.swift
//  weather-app
//
//  Created by Guilherme Viana on 30/11/2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    func successFetchingData()
    func errorFetchingData(error: String)
}

class ViewModel {
    
    public var weatherData: WeatherData?
    private var weatherService: WeatherService = WeatherService()
    private weak var delegate: ViewModelProtocol?
    public func delegate(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func getWeather() -> WeatherModel {
        let id = weatherData?.weather[0].id ?? Int()
        let cityName = weatherData?.name ?? ""
        let temperature = weatherData?.main.temp ?? Double()
        let weather = WeatherModel(conditionid: id, cityName: cityName, temperature: temperature)
        return weather
    }

    public func fetchDataFromServiceByCityName(cityname: String) {
        weatherService.fetchWeatherByCityName(cityName: cityname) { data, error in
            if error == nil {
                self.weatherData = data
                self.delegate?.successFetchingData()
            } else {
                self.delegate?.errorFetchingData(error: error?.localizedDescription ?? "")
            }
        }
    }
    
    public func fetchDataFromServiceByCoordinates(lat: Double, lon: Double) {
        weatherService.fetchWeatherByCoordinates(lat: lat, lon: lon) { data, error in
            if error == nil {
                self.weatherData = data
                self.delegate?.successFetchingData()
            } else {
                self.delegate?.errorFetchingData(error: error?.localizedDescription ?? "")
            }
        }
    }
    
}
