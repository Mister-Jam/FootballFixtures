//
//  TeamPlayersListViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/29/21.
//

import Foundation


struct TeamPlayersListViewModel {
    var playerShirtNumber: String
    var playerName: String
    var playerPosition: String
    var shirtNumber: Int?
    
    
    init(dataSource: PlayerModel) {
        if let shirtNumber = dataSource.shirtNumber,
           let position = dataSource.position {
            self.playerShirtNumber = "\(shirtNumber)"
            self.playerPosition = position
        } else {
            self.playerShirtNumber = " "
            self.playerPosition = "Not Available"
        }
        self.playerName = dataSource.name
        self.shirtNumber = dataSource.shirtNumber
    }
    
}
