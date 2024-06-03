//
//  ArrayExtnsTests.swift
//  WeatherAppTests
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import XCTest
@testable import WeatherApp


class ArrayExtnsTests: XCTestCase {
    
    func test_objectAt_not_nil() {
        let array = [1, 2, 3, 4]
        let object = array.object(at: 3)
        XCTAssertNotNil(object)
    }
    
    func test_objectAt_nil() {
        let array = [1, 2, 3, 4]
        let object = array.object(at: 4)
        XCTAssertNil(object)
    }
    
    func test_objectAt_value() {
        let array = [1, 2, 3, 4]
        let object = array.object(at: 3)
        XCTAssertEqual(object, 4)
    }
}
