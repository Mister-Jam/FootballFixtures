//
//  PlayersListTableViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/26/21.
//

import UIKit

class PlayersListTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private let playerNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let playerNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let playerPositionLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private func setupSubviews() {
        contentView.addMultipleSub(views: [playerNumberLabel, playerNameLabel, playerPositionLabel])
        constraints()
    }
    
    private func constraints() {
        let itemHeight: CGFloat = contentView.height*0.8
        let itemWidth: CGFloat = contentView.width*0.4
        let centerPoint: CGFloat = (contentView.bottom-itemHeight)/2
        
        playerNumberLabel.frame = CGRect(x: 20, y: centerPoint, width: 30, height: itemHeight)

        playerNameLabel.frame = CGRect(x: playerNumberLabel.right+10, y: centerPoint, width: itemWidth, height: itemHeight)
        
        playerPositionLabel.frame = CGRect(x: contentView.right-contentView.width*0.3, y: centerPoint, width: contentView.width*0.3, height: itemHeight)
    }

}

extension PlayersListTableViewCell: ConfigureWithViewModel {
    
    func configure(with model: TeamPlayersListViewModel) {
        playerNumberLabel.text = model.playerShirtNumber
        playerPositionLabel.text = model.playerPosition
        playerNameLabel.text = model.playerName
    }
}
