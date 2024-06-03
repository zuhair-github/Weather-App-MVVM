//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RxSwift

protocol Services {
    func getWeatherData(latitude: Double, longitude: Double) -> Observable<WeatherData>
    func getTodayWeatherData(forCity: String) -> Observable<WeatherData>
    func getWeatherForecastData(forCity city: String, days: Int) -> Observable<WeatherForecastData>
}

class WeatherServices: Services {
    
    let client: Client
    let parser: Parser
    let appId: String
    
    var disposeBag = DisposeBag()
    
    init(client: Client, parser: Parser, appId: String) {
        self.client = client
        self.parser = parser
        self.appId = appId
    }
    
    func getWeatherData(latitude: Double, longitude: Double) -> RxSwift.Observable<WeatherData> {
        return client.fetchData(route: Routes.weather, header: [:], parameters: ["lat": latitude, "lon": longitude, "appid": appId])
            .flatMap { self.parser.parse(data: $0, toType: WeatherData.self) }
    }
    
    func getTodayWeatherData(forCity city: String) -> Observable<WeatherData> {
        return client.fetchData(route: Routes.weather, header: [:], parameters: ["q": city, "appid": appId])
            .flatMap { self.parser.parse(data: $0, toType: WeatherData.self) }
    }
    
    func getWeatherForecastData(forCity city: String, days: Int) -> Observable<WeatherForecastData> {
        return client.fetchData(route: Routes.forecast, header: [:], parameters: ["q": city, "cnt": "\(days)", "appid": appId])
            .flatMap { self.parser.parse(data: $0, toType: WeatherForecastData.self) }
    }
    
    
}
