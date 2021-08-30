//
//  TodaysFixtureModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import Foundation

struct TodaysFixtureModel {
    var startTime: String
    var description: String
    var homwTeam: String
    var awayTeam: String
    var homwTeamScore: String
    var awayTeamScore: String
}

struct TodaysMatchesModel: Decodable {
    var count: Int
    var matches: [Matches]
}

struct Matches: Decodable {
    var utcDate: String
    var matchday: Int
    var score: Score
    var homeTeam: Team
    var awayTeam: Team
}

struct Score: Decodable {
    var fullTime: FullTime
}

struct FullTime: Decodable {
    var homeTeam: Int?
    var awayTeam: Int?
}

struct Team: Decodable {
    var id: Int
    var name: String
}
