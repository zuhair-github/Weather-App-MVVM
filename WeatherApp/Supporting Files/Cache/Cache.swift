//
//  Cache.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RealmSwift

protocol Cache {
    func getCities() -> [City]
    func addCity(name: String)
    func removeCity(name: String) -> Bool
    func setFavorite(for cityName: String, favorite: Bool) -> Bool
}

// MARK: - Realm Cache
class RealmCache: Cache {
    
    let realm = try! Realm()
    
    func getCities() -> [City] {
        let result = realm.objects(City.self)
        return result.map { $0 }
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
    
    func setFavorite(for cityName: String, favorite: Bool) -> Bool {
        guard let city = realm.objects(City.self).filter("name == %@", cityName).first else {
            return false
        }
        
        do {
            try realm.write {
                city.favorite = favorite
            }
            return true
        } catch {
            print("Error updating city: \(error)")
        }
        return false
    }
}

// MARK: - Favorites Cache
class RealmFavoritesCache: RealmCache {
    
    override func getCities() -> [City] {
        let result = realm.objects(City.self)
        return result.filter { $0.favorite }
    }
    
}
