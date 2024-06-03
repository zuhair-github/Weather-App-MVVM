//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RxSwift
import RxSwiftExt


protocol DetailsViewModelInput {
    func loadData()
}
protocol DetailsViewModelOutput {
    var forecaseDays: Int { get }
    var todayWeatherViewModel: Observable<TodayWeatherCellViewModelType> { get }
    var forecastWeatherViewModel: Observable<[ForecastCellViewModelType]> { get }
    var showError: Observable<String> { get }
}

protocol DetailsViewModelType {
    var input: DetailsViewModelInput { get }
    var output: DetailsViewModelOutput { get }
}

class DetailsViewModel: DetailsViewModelType, DetailsViewModelOutput, DetailsViewModelInput {
    
    // MARK: - Type
    var input: DetailsViewModelInput { self }
    var output: DetailsViewModelOutput { self }
    
    // MARK: - Input
    func loadData() {
        getTodayWeather()
        getWeatherForecast()
    }
    
    // MARK: - Output
    var forecaseDays: Int { return weatherForecaseDays }
    var showError: Observable<String> { showErrorSubject.asObserver() }
    var todayWeatherViewModel: Observable<TodayWeatherCellViewModelType> { todayWeatherViewModelSubject.asObserver() }
    var forecastWeatherViewModel: Observable<[ForecastCellViewModelType]> { forcastWeatherViewModelSubject.asObserver() }
    
    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
    private let weatherForecaseDays = 7
    private let showErrorSubject = PublishSubject<String>()
    private let todayWeatherViewModelSubject = PublishSubject<TodayWeatherCellViewModelType>()
    private let forcastWeatherViewModelSubject = PublishSubject<[ForecastCellViewModelType]>()
    
    // MARK: - Init Properties
    private let services: Services
    private let city: String
    
    // MARK: - Initializer
    init(services: Services, city: String) {
        self.services = services
        self.city = city
    }
    
    // MARK: - Private Functions
    private func getTodayWeather() {
        let results = self.services.getTodayWeatherData(forCity: city)
        results.map({ TodayWeatherCellViewModel(data: $0) })
            .subscribe(
                onNext: { [weak self] in self?.todayWeatherViewModelSubject.onNext($0) },
                onError: { [weak self] in self?.showErrorSubject.onNext($0.localizedDescription) })
            .disposed(by: disposeBag)
    }
    
    private func getWeatherForecast() {
        let results = self.services.getWeatherForecastData(forCity: city, days: weatherForecaseDays)
        results
            .map({ $0.list.map { ForecastCellViewModel(data: $0) } })
            .subscribe(
                onNext: { [weak self] in self?.forcastWeatherViewModelSubject.onNext($0) },
                onError: { [weak self] in self?.showErrorSubject.onNext($0.localizedDescription) })
            .disposed(by: disposeBag)
        
    }
    
}
