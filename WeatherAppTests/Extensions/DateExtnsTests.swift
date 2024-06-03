//
//  DateExtnsTests.swift
//  WeatherAppTests
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import XCTest
@testable import WeatherApp

class DateExtnsTests: XCTestCase {
    
    func test_string_value_function() {
        let dateString = "22-02-2013T14:30:00"
        let date = dateString.dateValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        let results = date?.stringValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        XCTAssertEqual(dateString, results)
        
    }
    
    func test_adding_hour() {
        let expectedResults = "22-02-2013T15:30:00"
        let date = "22-02-2013T14:30:00".dateValue(format: "dd-MM-yyyy'T'HH:mm:ss")?.dateByAdding(hours: 1)
        let results = date?.stringValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        XCTAssertEqual(results, expectedResults)
    }
    
    func test_adding_day() {
        let expectedResults = "23-02-2013T14:30:00"
        let date = "22-02-2013T14:30:00".dateValue(format: "dd-MM-yyyy'T'HH:mm:ss")?.dateByAdding(days: 1)
        let results = date?.stringValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        XCTAssertEqual(results, expectedResults)
    }
    
    func test_adding_month() {
        let expectedResults = "22-03-2013T14:30:00"
        let date = "22-02-2013T14:30:00".dateValue(format: "dd-MM-yyyy'T'HH:mm:ss")?.dateByAdding(months: 1)
        let results = date?.stringValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        XCTAssertEqual(results, expectedResults)
    }
    
    func test_adding_year() {
        let expectedResults = "22-02-2014T14:30:00"
        let date = "22-02-2013T14:30:00".dateValue(format: "dd-MM-yyyy'T'HH:mm:ss")?.dateByAdding(years: 1)
        let results = date?.stringValue(format: "dd-MM-yyyy'T'HH:mm:ss")
        XCTAssertEqual(results, expectedResults)
    }
}
