//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import CoreLocation

protocol LocationProvider {
    func getCurrentLocation(completion: @escaping (_ location: CLLocation?, _ error: Error?) -> Void)
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationProvider {
    
    // MARK: - Properties
    private var locationManager = CLLocationManager()
    var completion: ((_ location: CLLocation?, _ error: Error?) -> Void)?

    // MARK: - Init
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func getCurrentLocation(completion: @escaping (_ location: CLLocation?, _ error: Error?) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.completion = completion
    }

    // MARK: - Location Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        completion?(location, nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil, error)
    }
}
