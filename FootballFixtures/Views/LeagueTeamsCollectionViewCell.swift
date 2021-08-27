//
//  LeagueTableCollectionViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueTeamsCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let teamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let teamName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "900"
        label.numberOfLines = 2
        label.backgroundColor = .gray
        return label
    }()
    
    private func setupSubviews() {
        addSubview(containerView)
        containerView.addMultipleSub(views: [teamLogo, teamName])
        
        containerView.frame = CGRect(x: 5, y: 5, width: contentView.width-10, height: contentView.height-10)
        
        teamLogo.centerXAnchor(anchor: containerView.centerXAnchor)
            .topAnchor(anchor: containerView.topAnchor, constant: 20)
            .heightAnchorConstant(containerView.height*0.5)
            .widthAnchorConstant(containerView.width*0.7)
        
        teamName.centerXAnchor(anchor: containerView.centerXAnchor)
            .topAnchor(anchor: teamLogo.bottomAnchor, constant: 10)
            .widthAnchorConstant(containerView.width*0.7)
            .heightAnchorConstant(containerView.height*0.2)
    }
    
}
