//
//  City.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RealmSwift

class City: Object {
    var current = false
    @objc dynamic var name: String = ""
    @objc dynamic var favorite: Bool = false
    
    static func getInstance(name: String, favorite: Bool = false, current: Bool = false) -> City {
        let city = City()
        city.name = name
        city.favorite = favorite
        city.current = current
        return city
    }
}
