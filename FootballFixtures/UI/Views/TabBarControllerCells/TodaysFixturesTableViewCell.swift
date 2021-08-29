//
//  TodaysFixturesTableViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class TodaysFixturesTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellSubviews()
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private let teamLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private func setupCellSubviews() {
        contentView.addMultipleSub(views: [timeLabel, teamLabel,
                                            scoreLabel, descriptionLabel])
        setupFrames()
    }
    
    private func setupFrames() {
        timeLabel.frame = CGRect(x: 20, y: 10, width: contentView.width*0.17, height: contentView.height*0.65)
        descriptionLabel.frame = CGRect(x: 20, y: timeLabel.bottom-5, width: contentView.width*0.1, height: contentView.height*0.2)
        
        teamLabel.frame = CGRect(x: timeLabel.right+5, y: 10, width: contentView.width*0.55, height: contentView.height-20)
        
        scoreLabel.frame = CGRect(x: contentView.right-(contentView.width*0.1)-5, y: 7, width: contentView.width*0.1, height: contentView.height-14)
    }
}

extension TodaysFixturesTableViewCell: ConfigureWithViewModel {
    
    func configure(with model: TodaysFixturesViewModel) {
        if let time = model.formatDate() {
            timeLabel.attributedText = time
        }
        descriptionLabel.attributedText = model.matchday
        teamLabel.attributedText = model.team
        scoreLabel.attributedText = model.scores
    }
}
