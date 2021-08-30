//
//  LeagueStandingsViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation

struct LeagueStandingsViewModel {
    var teamPosition: Int
    var teamLogoUrl: String
    var teamName: String
    var matchesPlayed: Int
    var goalDifference: Int
    var totalPoints: Int
    var teamID: Int
    
    init(dataSource: TeamTable) {
        teamPosition = dataSource.position
        teamLogoUrl = dataSource.team.crestUrl
        teamName = dataSource.team.name
        matchesPlayed = dataSource.playedGames
        goalDifference = dataSource.goalDifference
        totalPoints = dataSource.points
        teamID = dataSource.team.id
    }
}




