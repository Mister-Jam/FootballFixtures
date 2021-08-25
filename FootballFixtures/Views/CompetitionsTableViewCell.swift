//
//  CompetitionsTableViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class CompetitionsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let competitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kaneki Ken is the actor in charge"
        return label
    }()
    
    private func setupCellLayout() {
        contentView.addSubview(competitionLabel)
        competitionLabel.leadingAnchor(anchor: contentView.leadingAnchor, constant: 20)
            .centerYAnchor(anchor: contentView.centerYAnchor)
            .heightAnchorConstant(52)
    }
    
}
