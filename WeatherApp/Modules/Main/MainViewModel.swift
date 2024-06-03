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
    func toggleFavorite(at index: Int)
}
protocol MainViewModelOutput {
    var cities: Observable<[City]> { get }
    func city(at index: Int) -> City?
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
    private var cachedCities: [City] = []
    private var currentCity: CurrentCity?
    
    private let citiesSubjects: PublishSubject<[City]> = PublishSubject<[City]>()
    private let showErrorSubject = PublishSubject<String>()
    
    
    // MARK: - Init Properties
    private let cache: Cache
    private let services: Services
    private let locationProvider: LocationProvider?
    
    // MARK: - Initializer
    init(services: Services, cache: Cache, locationProvider: LocationProvider?) {
        self.services = services
        self.cache = cache
        self.locationProvider = locationProvider
    }
    
    // MARK: - Type
    var input: MainViewModelInput { self }
    var output: MainViewModelOutput { self }
    
    // MARK: - Outnput
    var cities: Observable<[City]> { citiesSubjects.asObservable() }
    
    func city(at index: Int) -> City? {
        var index = index
        if let city = currentCity {
            if index == 0 {
                return City.getInstance(name: city.name ?? "", current: true)
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
        reloadData()
        getCurrentLocation()
    }
    
    func reloadData() {
        cachedCities = cache.getCities()
        var cities = cachedCities
        
        if let currentCity = currentCity?.name {
            let c = City.getInstance(name: currentCity, current: true)
            cities.insert(c, at: 0)
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
        if let city = cachedCities.object(at: index), cache.removeCity(name: city.name) {
            reloadData()
        }
    }
    
    func toggleFavorite(at index: Int) {
        var index = index
        if currentCity != nil {
            index -= 1
        }
        if let city = cachedCities.object(at: index), cache.setFavorite(for: city.name, favorite: !city.favorite) {
            reloadData()
        }
    }
    
    func addCity(name cityName: String) {
        cache.addCity(name: cityName)
        reloadData()
    }
    
    func getCurrentLocation() {
        guard currentCity == nil else { return }
        locationProvider?.getCurrentLocation { location, error in
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
                    cities.insert(City.getInstance(name: cityName, current: true), at: 0)
                    self.citiesSubjects.onNext(cities)
                },
                onError: {  [weak self] in
                    self?.showErrorSubject.onNext($0.localizedDescription)
                })
            .disposed(by: disposeBag)
    }
    
}
