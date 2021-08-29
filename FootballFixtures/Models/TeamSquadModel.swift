//
//  CompetitionFixturesModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation

struct TeamSquadModel: Decodable {
    var count: Int
    var matches: [CompetitionMatches]
}

struct CompetitionMatches: Decodable {
    
}

struct CompetitionSeason: Decodable {
    
}
