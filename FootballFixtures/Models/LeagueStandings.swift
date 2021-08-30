//
//  File.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation

struct LeagueTableStandingsModel: Decodable {
    var standings: [TableStandings]
}

struct TableStandings: Decodable {
    var table: [TeamTable]
}

struct TeamTable: Decodable {
    var position: Int
    var team: TeamModel
    var playedGames: Int
    var points: Int
    var goalDifference: Int
}

struct TeamModel: Decodable {
    var id: Int
    var name: String
    var crestUrl: String
}

