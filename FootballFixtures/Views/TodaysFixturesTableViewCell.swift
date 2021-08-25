//
//  TodaysFixturesTableViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class TodaysFixturesTableViewCell: UITableViewCell, CellInputsIO {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellData = TodaysFixtureModel(startTime: "13:00", description: "MD:39", firstTeam: "Pro Verceli", secondTeam: "Frosinone Calcio", firstTeamScore: "0", secondTeamScore: "0", minutes: "22'")
        setupCellSubviews()
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let teamLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    private let minutesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var cellData: TodaysFixtureModel? {
        didSet {
            
            guard let item = cellData else { return }
            timeLabel.attributedText = formatText(firstText: "TIMED\n", secondText: "\(item.startTime)", firstColor: .black, secondColor: .black, firstFont: .smallHeaderFont!, secondFont: .headerFont!)
            descriptionLabel.attributedText = formatText(firstText: item.description, secondText: nil, firstColor: .gray, secondColor: .black, firstFont: .smallFont!, secondFont: .smallFont!)
            teamLabel.attributedText = formatText(firstText: "\(item.firstTeam)", secondText: "\n\(item.secondTeam)", firstColor: .black, secondColor: .black, firstFont: .headerFont!, secondFont: .headerFont!)
            minutesLabel.attributedText = formatText(firstText: item.minutes, secondText: nil, firstColor: .gray, secondColor: .black, firstFont: .smallFont!, secondFont: .smallFont!)
            scoreLabel.attributedText = formatText(firstText: item.firstTeamScore, secondText: "\n\n\(item.secondTeamScore)", firstColor: .black, secondColor: .black, firstFont: .headerFont!, secondFont: .headerFont!)
        }
    }
    
    private func setupCellSubviews() {
        contentView.addMultipleSub(views: [timeLabel, teamLabel, minutesLabel,
                                            scoreLabel, descriptionLabel])
        setupFrames()
    }
    
    private func setupFrames() {
        timeLabel.frame = CGRect(x: 20, y: 10, width: contentView.width*0.15, height: contentView.height*0.65)
        descriptionLabel.frame = CGRect(x: 20, y: timeLabel.bottom-5, width: contentView.width*0.1, height: contentView.height*0.2)
        
        teamLabel.frame = CGRect(x: timeLabel.right+10, y: 10, width: contentView.width*0.6, height: contentView.height-20)
        
        minutesLabel.frame = CGRect(x: teamLabel.right, y: (contentView.height-20)/2, width: 30, height: 30)
        
        scoreLabel.frame = CGRect(x: minutesLabel.right, y: 7, width: contentView.width*0.1, height: contentView.height-14)
    }
}

extension TodaysFixturesTableViewCell {
    func formatText(firstText: String, secondText: String?,
                    firstColor: UIColor, secondColor: UIColor,
                    firstFont: UIFont, secondFont: UIFont) -> NSMutableAttributedString {
        
        let firstTextAttributes: [NSAttributedString.Key : NSObject] = [.font : firstFont, .foregroundColor : firstColor]
        let secondTextAttributes: [NSAttributedString.Key : NSObject] = [.font : secondFont, .foregroundColor : secondColor]
        let attributedText = NSMutableAttributedString(string: firstText, attributes: firstTextAttributes)
        if let secondText = secondText {
            attributedText.append(NSAttributedString(string: secondText, attributes: secondTextAttributes))
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: _NSRange(location: 0, length: length))
        return attributedText
    }
}
