//
//  LeagueTeamsViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/30/21.
//

import Foundation

struct LeagueTeamsViewModel {
    static var leagueTeamsData = [TeamModel]()
    var teamName: String
    var teamLogoUrl: String
    var teamID: Int
    
    init(dataSource: TeamModel) {
        teamName = dataSource.name
        teamID = dataSource.id
        teamLogoUrl = dataSource.crestUrl
    }
}
