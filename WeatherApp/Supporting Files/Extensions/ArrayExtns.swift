//
//  ArrayExtns.swift
//  MyApp
//
//  Created by Zuhair Hussain on 13/12/2021.
//

import Foundation


extension Array {
    func object(at index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}

extension Array where Element == String {
    func containsCaseInsensitive(_ newValue: String) -> Bool {
        let contains = self.contains { $0.compare(newValue, options: .caseInsensitive) == .orderedSame }
        return contains
    }
}
