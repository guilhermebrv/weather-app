//
//  WeatherService.swift
//  weather-app
//
//  Created by Guilherme Viana on 30/11/2023.
//

import Foundation

enum ErrorDetail: Swift.Error {
    case errorURL(urlString: String)
    case detailError(detail: String)
}

struct WeatherService {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7e6c2af0008f8de4eb95da6ba76da7ed&units=metric"
    
    public func fetchWeatherByCityName(cityName: String, completion: @escaping(WeatherData?, Error?) -> Void) {
        let urlString: String = "\(weatherURL)&q=\(cityName)"
        guard let url: URL = URL(string: urlString) else { return completion(nil, ErrorDetail.errorURL(urlString: urlString)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        performTask(with: request, completion: completion)
    }
    
    public func fetchWeatherByCoordinates(lat: Double, lon: Double, completion: @escaping(WeatherData?, Error?) -> Void) {
        let urlString: String = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        guard let url: URL = URL(string: urlString) else { return completion(nil, ErrorDetail.errorURL(urlString: urlString)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        performTask(with: request, completion: completion)
    }
    
    private func performTask(with request: URLRequest, completion: @escaping(WeatherData?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let dataResult = data else { return completion(nil, ErrorDetail.detailError(detail: "Couldn't fetch data from specified URL")) }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: dataResult)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, ErrorDetail.detailError(detail: "Error parsing JSON"))
                }
            } else {
                completion(nil, ErrorDetail.detailError(detail: "Status code from response is not 200!"))
            }
        }
        task.resume()
    }
}
