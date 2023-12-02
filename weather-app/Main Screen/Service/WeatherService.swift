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
    /*
    public func fetchData(cityName: String) {
        let urlString: String = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    private func performRequest(urlString: String) {
        if let url: URL = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                    let datastring = String(data: safeData, encoding: .utf8)
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
        } catch {
            print(error)
        }
    }
    */
    public func fetchWeather(cityName: String, completion: @escaping(WeatherData?, Error?) -> Void) {
        let urlString: String = "\(weatherURL)&q=\(cityName)"
        guard let url: URL = URL(string: urlString) else { return completion(nil, ErrorDetail.errorURL(urlString: urlString)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let dataResult = data else { return completion(nil, ErrorDetail.detailError(detail: "Couldn't fetch data from specified URL")) }
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: dataResult)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
