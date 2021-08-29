//
//  SpinnerViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner                 = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        view                    = UIView()
        view.backgroundColor    = #colorLiteral(red: 0.9137254902, green: 0.8705882353, blue: 0.9803921569, alpha: 1)
        
        spinner.color           = .darkGray
        spinner.startAnimating()
        
        constraints()
    }
    
    public func start(container: UIViewController) {
        container.addChild(self)
        self.view.frame         = container.view.frame
        container.view.addSubview(self.view)
        self.didMove(toParent: container)
    }
    
    public func stop() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private func constraints() {
        [spinner, spinnerLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        spinner.centerXAnchor(anchor: view.centerXAnchor)
            .centerYAnchor(anchor: view.centerYAnchor)
        
        spinnerLabel.topAnchor(anchor: spinner.bottomAnchor, constant: 20)
            .centerXAnchor(anchor: view.centerXAnchor)
    }
    
    public let spinnerLabel: UILabel   = {
        let label               = UILabel()
        label.font              = UIFont.systemFont(ofSize: 20)
        label.textAlignment     = .center
        label.textColor         = .black
        label.text              = "Please wait..."
        return label
    }()
    
}
