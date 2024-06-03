//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let weather: [Weather]?
    let main: Main?
    let name: String?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}


// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}


// MARK: - WeatherForecastData
struct WeatherForecastData: Codable {
    let list: [WeatherForcastReport]
}

// MARK: - List
struct WeatherForcastReport: Codable {
    let main: Main?
    let weather: [Weather]?

    enum CodingKeys: String, CodingKey {
        case main, weather
    }
}

struct CurrentCity {
    var name: String?
    var latitude: Double?
    var longitude: Double?
}

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let message: String
}
