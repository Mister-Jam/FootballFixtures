//
//  CompetitionLeagueTableViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "900"
        return label
    }()
    
    private let teamLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "That iis not the cause of your probs"
        return label
    }()
    
    private let numOfFixturesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let numOfGoalsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private let teamPointsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    
    private lazy var scoresStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [numOfFixturesLabel, numOfGoalsLabel, teamPointsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private func setupSubViews() {
        contentView.addMultipleSub(views: [indexLabel, teamLogo, teamNameLabel, scoresStackView])
        let itemHeight: CGFloat = contentView.height-18
        let stackWidth: CGFloat = contentView.width*0.23
        
        indexLabel.leadingAnchor(anchor: contentView.leadingAnchor, constant: 15)
            .centerYAnchor(anchor: contentView.centerYAnchor)
            .heightAnchorConstant(itemHeight)
        
        teamLogo.leadingAnchor(anchor: indexLabel.trailingAnchor, constant: 15)
            .centerYAnchor(anchor: contentView.centerYAnchor)
            .heightAnchorConstant(itemHeight)
            .widthAnchorConstant(itemHeight)
        
        teamLogo.layer.cornerRadius = (itemHeight)/2
        
        teamNameLabel.leadingAnchor(anchor: teamLogo.trailingAnchor, constant: 15)
            .centerYAnchor(anchor: contentView.centerYAnchor)
            .heightAnchorConstant(itemHeight)
            .widthAnchorConstant(contentView.width*0.45)
        
        scoresStackView.frame = CGRect(x: contentView.right-(stackWidth)-10, y: 5,
                                       width: stackWidth, height: itemHeight)
        
    }
    
}
