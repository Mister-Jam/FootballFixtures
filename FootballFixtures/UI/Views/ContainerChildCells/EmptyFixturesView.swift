//
//  EmptyFixturesView.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/26/21.
//

import UIKit

class EmptyFixturesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    private let ballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "soccer")
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyFixturesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Fixtures"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightText
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.setTitle("Retry", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupSubviews() {
        addMultipleSub(views: [ballImage, emptyFixturesLabel, retryButton])
        self.alpha = 0.5
        constraints()
    }
    
    private func constraints() {
        ballImage.centerXAnchor(anchor: self.centerXAnchor)
            .centerYAnchor(anchor: self.centerYAnchor, constant: -20)
            .heightAnchorConstant(100)
            .widthAnchorConstant(100)
        
        emptyFixturesLabel.topAnchor(anchor: ballImage.bottomAnchor, constant: 30)
            .widthAnchorConstant(150)
            .heightAnchorConstant(25)
            .centerXAnchor(anchor: self.centerXAnchor)
        
        retryButton.centerXAnchor(anchor: self.centerXAnchor)
            .widthAnchorConstant(200)
            .heightAnchorConstant(52)
            .topAnchor(anchor: emptyFixturesLabel.bottomAnchor, constant: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
