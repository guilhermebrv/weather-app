//
//  WeatherManager.swift
//  weather-app
//
//  Created by Guilherme Viana on 02/12/2023.
//

import Foundation

struct WeatherModel {
    let conditionid: Int
    let cityName: String
    let temperature: Double
    
    var temperatureFormatted: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionid {
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
}
