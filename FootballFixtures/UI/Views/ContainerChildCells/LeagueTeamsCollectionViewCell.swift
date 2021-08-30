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
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let teamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.image = Constants.Images.soccer
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let teamName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
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
            .heightAnchorConstant(containerView.height*0.25)
    }
    
}

extension LeagueTeamsCollectionViewCell: ConfigureWithViewModel {
    func configure(with model: LeagueTeamsViewModel) {
        teamName.text = model.teamName
        guard let url = URL(string: model.teamLogoUrl) else { return }
        teamLogo.sd_setImage(with: url, placeholderImage: Constants.Images.soccer, options: [], context: nil)
    }
}
