//
//  CompetitionsModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import Foundation


struct CompetitionsListModel: Decodable {
    var count: Int
    var competitions: [Competitions]
}

struct Competitions: Decodable {
    var id: Int
    var name: String
    var currentSeason: CurrentSeason?
    
}

struct CurrentSeason: Decodable {
    var startDate: String
    var endDate: String
}
