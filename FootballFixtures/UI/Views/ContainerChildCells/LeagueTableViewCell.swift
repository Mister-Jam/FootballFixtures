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
        return label
    }()
    
    private let teamLogo: UIImageView   = {
        let imageView                       = UIImageView()
        imageView.layer.cornerRadius        = 12
        imageView.layer.masksToBounds       = true
        imageView.layer.borderWidth         = 0.1
        imageView.image                     = UIImage(named: "currently-unavailable")
        imageView.contentMode               = .scaleAspectFit
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let numOfFixturesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let numOfGoalsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let teamPointsLabel: UILabel = {
        let label = UILabel()
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
        let itemHeight: CGFloat = contentView.height-14
        let stackWidth: CGFloat = contentView.width*0.25
        let centerPoint: CGFloat = (contentView.bottom-itemHeight)/2
        
        indexLabel.frame = CGRect(x: 15, y: centerPoint,
                                  width: contentView.width*0.08, height: itemHeight)
        
        teamLogo.frame = CGRect(x: indexLabel.right+5, y: centerPoint, width: itemHeight, height: itemHeight)
                
        teamLogo.layer.cornerRadius = (itemHeight)/2
        teamNameLabel.frame = CGRect(x: teamLogo.right+10, y: centerPoint, width: contentView.width*0.45, height: itemHeight)
        
        scoresStackView.frame = CGRect(x: contentView.right-(stackWidth), y: 5,
                                       width: stackWidth, height: itemHeight)
    }
    
}

extension LeagueTableViewCell: ConfigureWithViewModel {
    
    func configure(with model: LeagueStandingsViewModel) {
        indexLabel.text = String(model.teamPosition)
        teamNameLabel.text = model.teamName
        numOfFixturesLabel.text = String(model.matchesPlayed)
        numOfGoalsLabel.text = String(model.goalDifference)
        teamPointsLabel.text = String(model.totalPoints)
        guard let url = URL(string: model.teamLogoUrl) else { return }
        let svgImageSize = CGSize(width: 100, height: 100)
        teamLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "soccer"), options: [], context: [.imageThumbnailPixelSize : svgImageSize])
        
    }
    
}
