//
//  Cache.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RealmSwift

protocol Cache {
    func getCities() -> [String]
    func addCity(name: String)
    func removeCity(name: String) -> Bool
}

class RealmCache: Cache {
    private let realm = try! Realm()
    
    func getCities() -> [String] {
        let result = realm.objects(City.self)
        return result.map { $0.name }
    }
    
    func addCity(name: String) {
        let city = City()
        city.name = name
        try? self.realm.write {
            self.realm.add(city)
        }
    }
    
    func removeCity(name: String) -> Bool {
        guard let city = realm.objects(City.self).filter("name == %@", name).first else {
            return false
        }
        
        do {
            try realm.write {
                realm.delete(city)
            }
            return true
        } catch {
            print("Error deleting city: \(error)")
        }
        return false
    }
}
