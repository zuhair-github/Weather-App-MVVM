//
//  ViewControllerFactory.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import Foundation

class ViewControllerFactory {
    
    func createMainView(coordinator: Coordinator) -> MainView {
        let services = createWeatherServices()
        let cache = createRealmCache()
        let locationProvider = createLocationProvider()
        
        let viewModel = MainViewModel(services: services, cache: cache, locationProvider: locationProvider)
        let view = MainView(viewModel: viewModel, coordinator: coordinator)
        return view
    }
    
    func createDetailsView(coordinator: Coordinator, city: String) -> DetailsView {
        let services = createWeatherServices()
        
        let viewModel = DetailsViewModel(services: services, city: city)
        let view = DetailsView(viewModel: viewModel, coordinator: coordinator)
        return view
    }
    
    
    // MARK: - Private Methods
    private func createAPIClient() -> APIClient {
        let apiClient = APIClient(baseUrl: Configurations.shared.baseUrl)
        return apiClient
    }
    
    private func createParser() -> ObjectParser {
        let objectParser = ObjectParser()
        return objectParser
    }
    
    private func createWeatherServices() -> WeatherServices {
        let weatherServices = WeatherServices(client: createAPIClient(), parser: createParser(), appId: Configurations.shared.appId)
        return weatherServices
    }
    
    private func createRealmCache() -> RealmCache {
        let cache = RealmCache()
        return cache
    }
    
    private func createLocationProvider() -> LocationProvider {
        let locationProvider = LocationManager()
        return locationProvider
    }
    
}
