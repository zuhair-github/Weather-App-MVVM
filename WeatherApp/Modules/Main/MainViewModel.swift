//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RxSwift

protocol MainViewModelInput {
    func loadData()
    func validateAndAddCity(name cityName: String)
    func removeCity(at index: Int)
}
protocol MainViewModelOutput {
    var cities: Observable<[String]> { get }
    func city(at index: Int) -> String?
    func shouldEdit(at index: Int) -> Bool
    var showError: Observable<String> { get }
}

protocol MainViewModelType {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}


class MainViewModel: MainViewModelInput, MainViewModelOutput, MainViewModelType {
    
    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
    private var cachedCities: [String] = []
    private var currentCity: CurrentCity?
    
    private let citiesSubjects: PublishSubject<[String]> = PublishSubject<[String]>()
    private let showErrorSubject = PublishSubject<String>()
    
    
    // MARK: - Init Properties
    private let cache: Cache
    private let services: Services
    private let locationProvider: LocationProvider
    
    // MARK: - Initializer
    init(services: Services, cache: Cache, locationProvider: LocationProvider) {
        self.services = services
        self.cache = cache
        self.locationProvider = locationProvider
    }
    
    // MARK: - Type
    var input: MainViewModelInput { self }
    var output: MainViewModelOutput { self }
    
    // MARK: - Outnput
    var cities: Observable<[String]> { citiesSubjects.asObservable() }
    
    func city(at index: Int) -> String? {
        var index = index
        if let city = currentCity {
            if index == 0 {
                return city.name
            }
            index -= 1
        }
        return cachedCities.object(at: index)
    }
    
    func shouldEdit(at index: Int) -> Bool {
        if currentCity != nil && index == 0 {
            return false
        }
        return true
    }
    
    // MARK: - Input
    var showError: Observable<String> { showErrorSubject.asObservable() }
    
    func loadData() {
        cachedCities = cache.getCities()
        self.citiesSubjects.onNext(self.cachedCities)
        getCurrentLocation()
    }
    
    func reloadData() {
        cachedCities = cache.getCities()
        var cities = cachedCities
        
        if let currentCity = currentCity?.name {
            cities.insert(currentCity, at: 0)
        }
        self.citiesSubjects.onNext(cities)
    }
    
    func validateAndAddCity(name cityName: String) {
        if cachedCities.containsCaseInsensitive(cityName) {
            self.showErrorSubject.onNext("City already added")
            return
        }
        self.services.getTodayWeatherData(forCity: cityName)
            .subscribe(
                onNext: { [weak self] data in
                    guard let self, data.name != nil else {
                        self?.showErrorSubject.onNext("City not found")
                        return
                    }
                    self.addCity(name: cityName)
                },
                onError: { [weak self] in
                    self?.showErrorSubject.onNext($0.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
    func removeCity(at index: Int) {
        var index = index
        if currentCity != nil {
            index -= 1
        }
        if let city = cachedCities.object(at: index), cache.removeCity(name: city) {
            reloadData()
        }
    }
    
    func addCity(name cityName: String) {
        cache.addCity(name: cityName)
        reloadData()
    }
    
    func getCurrentLocation() {
        locationProvider.getCurrentLocation { location, error in
            guard let location = location else { return }
            self.getLocationDetails(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func getLocationDetails(latitude: Double, longitude: Double) {
        services.getWeatherData(latitude: latitude, longitude: longitude)
            .subscribe (
                onNext: { [weak self] data in
                    guard let self, let cityName = data.name else { return }
                    self.currentCity = CurrentCity(name: cityName, latitude: latitude, longitude: longitude)
                    var cities = self.cachedCities
                    cities.insert(cityName, at: 0)
                    self.citiesSubjects.onNext(cities)
                },
                onError: {  [weak self] in
                    self?.showErrorSubject.onNext($0.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
}
