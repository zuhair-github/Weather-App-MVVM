//
//  UIElementsExtns.swift
//  MyApp
//
//  Created by Zuhair Hussain on 09/12/2021.
//

import UIKit
import SDWebImage


// MARK: - UIViewController
extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UIView
extension UIView {
    var x: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }
    var y: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    var height: CGFloat {
        set { frame.size.height = newValue }
        get { return frame.height }
    }
    var width: CGFloat {
        set { frame.size.width = newValue }
        get { return frame.width }
    }
}

//MARK: Layout Constraints
extension UIView {
    
    @discardableResult
    func height (_ constant: CGFloat, priority:Float = 1000) -> UIView {
        let height = heightAnchor.constraint(equalToConstant: constant)
        height.priority = UILayoutPriority(priority)
        height.isActive = true
        return self
    }
    @discardableResult
    func height(_ equalTo: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let height = heightAnchor.constraint(equalTo: equalTo, multiplier: multiplier, constant: constant)
        height.priority = UILayoutPriority(priority)
        height.isActive = true
        return self
    }
    
    @discardableResult
    func width(_ constant: CGFloat, priority:Float = 1000) -> UIView{
        let width = widthAnchor.constraint(equalToConstant: constant)
        width.priority = UILayoutPriority(priority)
        width.isActive = true
        return self
    }
    @discardableResult
    func width(_ equalTo: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let width = widthAnchor.constraint(equalTo: equalTo, multiplier: multiplier, constant: constant)
        width.priority = UILayoutPriority(priority)
        width.isActive = true
        return self
    }
    
    @discardableResult
    func top(_ equalTo:  NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let top = topAnchor.constraint(equalTo: equalTo, constant: constant)
        top.priority = UILayoutPriority(priority)
        top.isActive = true
        return self
    }
    @discardableResult
    func bottom(_ equalTo:  NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func left(_ equalTo:  NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let left = leftAnchor.constraint(equalTo: equalTo, constant: constant)
        left.priority = UILayoutPriority(priority)
        left.isActive = true
        return self
    }
    
    @discardableResult
    func right(_ equalTo:  NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let right = rightAnchor.constraint(equalTo: equalTo, constant: constant)
        right.priority = UILayoutPriority(priority)
        right.isActive = true
        return self
    }
    
    @discardableResult
    func centerX(_ equalTo:  NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let centerX = centerXAnchor.constraint(equalTo: equalTo, constant: constant)
        centerX.priority = UILayoutPriority(priority)
        centerX.isActive = true
        return self
    }
    
    @discardableResult
    func centerY(_ equalTo:  NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0, priority:Float = 1000) -> UIView {
        let centerY = centerYAnchor.constraint(equalTo: equalTo, constant: constant)
        centerY.priority = UILayoutPriority(priority)
        centerY.isActive = true
        return self
    }
    
    @discardableResult
    func setContentHugging(_ priority:Float, axix:NSLayoutConstraint.Axis ) -> UIView {
        setContentHuggingPriority(UILayoutPriority(priority), for: axix)
        return self
    }
    
    @discardableResult
    func setContentCompression(_ resistancePriority:Float, axix:NSLayoutConstraint.Axis ) -> UIView {
        setContentCompressionResistancePriority(UILayoutPriority(resistancePriority), for: axix)
        return self
    }
    
}



extension UITableViewCell {
    static var identifier: String {
        return "k\(String(describing: self))"
    }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UIImageView {
    func setImage(url: String?, placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        if let u = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            self.sd_setImage(with: URL(string: u), placeholderImage: placeholder) { _, _, _, _ in
                completion?()
            }
        } else {
            self.image = placeholder
            completion?()
        }
    }
    func setImage(url: String?, placeholderColor: UIColor?, completion: (() -> Void)? = nil) {
        self.backgroundColor = placeholderColor
        if let u = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            self.sd_setImage(with: URL(string: u), placeholderImage: nil) { _, _, _, _ in
                completion?()
            }
        } else {
            self.image = nil
            completion?()
        }
    }
}
