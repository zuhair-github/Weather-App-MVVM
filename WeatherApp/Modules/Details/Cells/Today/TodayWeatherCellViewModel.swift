//
//  TodayWeatherCellViewModel.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import Foundation

protocol TodayWeatherCellViewModelType {
    var city: String? { get }
    var temperature: String? { get }
    var summary: String? { get }
    var minTemperature: String? { get }
    var maxTemperature: String? { get }
    var description: String? { get }
}

class TodayWeatherCellViewModel: TodayWeatherCellViewModelType {
    
    var city: String?
    var temperature: String?
    var summary: String?
    var minTemperature: String?
    var maxTemperature: String?
    var description: String?
    
    
    init(data: WeatherData?) {
        city = data?.name ?? "--"
        if let temp = data?.main?.temp {
            temperature = "\(Int(temp) - 275)°"
        } else {
            temperature = "--"
        }
        summary = data?.weather?.first?.main ?? "--"
        if let max = data?.main?.tempMax, let min = data?.main?.tempMin {
            minTemperature = "\(Int(min) - 275)°"
            maxTemperature = "\(Int(max) - 275)°"
        } else {
            minTemperature = "--"
            maxTemperature = "--"
        }
        if let feelsLike = data?.main?.feelsLike {
            description = "Feel like \(Int(feelsLike) - 275)°"
        } else {
            description = "--"
        }
        
    }
    
}
