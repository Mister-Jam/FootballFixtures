//
//  CompetitionFixturesModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation

struct TeamSquadModel: Decodable {
    var name: String
    var crestUrl: String
    var squad: [PlayerModel]
}

struct PlayerModel: Decodable {
    var name: String
    var position: String?
    var shirtNumber: Int?
}

