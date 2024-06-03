//
//  UIFactory.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit


enum FontSize {
    case small
    case normal
    case medium
    case large
    case extraLarge
    case custom(value: CGFloat)
    
    var value: CGFloat {
        switch self {
        case .small: return 14
        case .normal: return 16
        case .medium: return 18
        case .large: return 20
        case .extraLarge: return 22
        case .custom(let value): return value
        }
    }
}

class UIFactory {
    
    static func createLabel(text: String? = "", fontSize: FontSize = .normal, textAlignment: NSTextAlignment = .natural, textColor: UIColor = .black) -> UILabel {
        let view = UILabel()
        view.text = text
        view.font = UIFont.systemFont(ofSize: fontSize.value)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = textAlignment
        view.textColor = textColor
        return view
    }
    
    static func createButton() -> UIButton {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createTableView() -> UITableView {
        let view = UITableView(frame: UIScreen.main.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }
    
    static func createSeparatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1)
        return view
    }
}
