//
//  Configurations.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import Foundation

class Configurations {
    
    static let shared = Configurations()
    
    let baseUrl: String
    let imageBaseUrl: String
    let appId: String
    
    init() {
        let plistPath = Bundle.main.path(forResource: "Configurations", ofType: "plist")!
        let data = FileManager.default.contents(atPath: plistPath)!

        let dictionary = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String: Any]
        baseUrl = dictionary["baseUrl"] as! String
        self.imageBaseUrl = dictionary["imageBaseUrl"] as! String
        self.appId = dictionary["appId"] as! String
    }
}
