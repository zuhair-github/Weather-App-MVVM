//
//  StringExtns.swift
//  MyApp
//
//  Created by Zuhair Hussain on 10/12/2021.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var toDate: Date? {
        var date: Date? = nil
        var dateString = self
        
        if dateString.contains("0000-01-01T") {
            dateString = dateString.replacingOccurrences(of: "0000-01-01T", with: Date().stringValue(format: "yyyy-MM-dd", timeZone: .current) + "T")
        }
        
        let formates = ["dd-MM-yyyy'T'HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SSSS", "yyyy-MM-dd'T'HH:mm:ss.SSSXXX", "yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ss", "dd MMM yyyy", "MM-dd-yyyy"]
        for f in formates {
            if let d = dateString.dateValue(format: f) {
                date = d
                break
            }
        }
        
        return date
    }
    
    func dateValue(format: String, timeZone: TimeZone? = TimeZone(abbreviation: "GMT")) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}

