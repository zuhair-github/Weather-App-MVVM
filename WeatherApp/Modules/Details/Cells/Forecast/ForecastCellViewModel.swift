//
//  ForecastCellViewModel.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import Foundation

protocol ForecastCellViewModelType {
    var iconUrl: String? { get }
    var minTemperature: String? { get }
    var maxTemperature: String? { get }
}


class ForecastCellViewModel: ForecastCellViewModelType {
    var iconUrl: String?
    var minTemperature: String?
    var maxTemperature: String?
    
    init(data: WeatherForcastReport?) {
        iconUrl = "\(Configurations.shared.imageBaseUrl)\(data?.weather?.first?.icon ?? "").png"
        
        if let max = data?.main?.tempMin, let min = data?.main?.tempMax {
            minTemperature = "\(Int(min) - 275)°"
            maxTemperature = "\(Int(max) - 275)°"
        } else {
            minTemperature = "--"
            maxTemperature = "--"
        }
    }
    
}
