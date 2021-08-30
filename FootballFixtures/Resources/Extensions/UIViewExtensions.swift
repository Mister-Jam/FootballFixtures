//
//  Extensions.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

extension UIView {
    
    var top: CGFloat {
        self.frame.origin.y
    }
    
    var bottom: CGFloat {
        self.frame.size.height + top
    }
    
    var left: CGFloat {
        self.frame.origin.x
    }
    
    var width: CGFloat {
        self.frame.size.width
    }
    
    var height: CGFloat {
        self.frame.size.height
    }
    
    var right: CGFloat {
        left + width
    }
    
    func addMultipleSub(views: [UIView] ) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    @discardableResult
    func heightAnchorConstant(_ constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    @discardableResult
    func heightAnchorMultiplier(dimension: NSLayoutDimension, multiplier: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
        return self
    }
    @discardableResult
    func heightAnchor(anchor: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = .zero) -> Self {
        heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func widthAnchorMultiplier(dimension: NSLayoutDimension, multiplier: CGFloat) -> Self {
        widthAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
        return self
    }
    @discardableResult
    func widthAnchorConstant(_ constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    @discardableResult
    func widthAnchor(anchor: NSLayoutAnchor<NSLayoutDimension>, constant: CGFloat = .zero) -> Self {
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func topAnchor(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func bottomAnchor(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func leadingAnchor(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func trailingAnchor(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func centerXAnchor(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    @discardableResult
    func centerYAnchor(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}

extension UIViewController {
    
    func setTabBarHidden(_ hidden: Bool) {
        guard let frame = self.tabBarController?.tabBar.frame else { return }
        if hidden {
            UIView.animate(withDuration: 0.3, animations: {
                self.tabBarController?.tabBar.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height, width: frame.width, height: frame.height)
            })
        } else {
            UIView.animate(withDuration: 0, animations: {
                self.tabBarController?.tabBar.frame = UITabBarController().tabBar.frame
            })
        }
        
    }

}
