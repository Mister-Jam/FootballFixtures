//
//  TodaysFixturesViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import UIKit

public struct TodaysFixturesViewModel {

    var time: NSMutableAttributedString
    var matchday: NSMutableAttributedString
    var team: NSMutableAttributedString
    var scores: NSMutableAttributedString
    var modelData: TodaysFixtureModel
    var matchDate: String
    
    init(dataSource: Matches) {
        let homeScore   = dataSource.score.fullTime.homeTeam ?? 0
        let awayScore   = dataSource.score.fullTime.awayTeam ?? 0
        modelData       = TodaysFixtureModel(startTime: dataSource.utcDate, description: "\(dataSource.matchday)", homwTeam: dataSource.homeTeam.name, awayTeam: dataSource.awayTeam.name, homwTeamScore: "\(homeScore)", awayTeamScore: "\(awayScore)")
        
        time            =  Constants.formatText(firstText: "TIMED\n", secondText: "\(modelData.startTime)", firstColor: .black, secondColor: .black, firstFont: .smallHeaderFont!, secondFont: .headerFont!)
        
        matchday        = Constants.formatText(firstText: "MD: \(modelData.description)", secondText: nil, firstColor: .gray, secondColor: .black, firstFont: .smallFont!, secondFont: .smallFont!)
        
        team            = Constants.formatText(firstText: "\(modelData.homwTeam)", secondText: "\n\n\(modelData.awayTeam)", firstColor: .black, secondColor: .black, firstFont: .headerFont!, secondFont: .headerFont!)
        
        scores          = Constants.formatText(firstText: modelData.homwTeamScore, secondText: "\n\n\(modelData.awayTeamScore)", firstColor: .black, secondColor: .black, firstFont: .headerFont!, secondFont: .headerFont!)
        
        matchDate       = modelData.startTime
    }
    
    public func formatDate() -> NSMutableAttributedString? {
        let dateString = matchDate
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateOfMatch = formatter.date(from: dateString)
        
        if let date = dateOfMatch {
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let min = minute == 0 ? "00" : "\(minute)"
            let matchTime = "\(hour):\(min)"
            return Constants.formatText(firstText: "TIMED\n", secondText: "\(matchTime)", firstColor: .black, secondColor: .black, firstFont: .smallHeaderFont!, secondFont: .headerFont!)
        }
        return nil
    }
}
