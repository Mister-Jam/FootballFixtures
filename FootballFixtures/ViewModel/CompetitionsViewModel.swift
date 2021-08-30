//
//  CompetitionsViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/28/21.
//

import Foundation


public struct CompetitionsListViewModel {
    let currentDate = Date()
    let formatter = DateFormatter()
    let calendar = Calendar.current
    var currentYear: Int
    var competitionName: String
    var competitionId: Int
    var startDate: String?
    var endDate: String?
    var competitions: Competitions
    
    init(dataSource: Competitions) {
        competitions = dataSource
        competitionName = competitions.name
        competitionId = competitions.id
        startDate = competitions.currentSeason?.startDate
        endDate = competitions.currentSeason?.endDate
        currentYear = calendar.component(.year, from: currentDate)
    }
    
    public func displayText () -> String {
        if let firstDate = startDate,
           let secondDate = endDate {
            formatter.dateFormat = "yyyy-MM-dd"
            guard let compStartDate = formatter.date(from: firstDate) else { return "" }
            guard let compEndDate = formatter.date(from: secondDate) else { return "" }
            let compStartYear = calendar.component(.year, from: compStartDate)
            let compEndYear = calendar.component(.year, from: compEndDate)
            return "\(competitionName) \(compStartYear)/\(compEndYear%100)"
        }
        return ""
    }
}

public struct FilterReturnedApiData {
    
    public var filteredData: [CompetitionsListViewModel]
    
    init(apiData: [Competitions]) {
        let data = (apiData.map { CompetitionsListViewModel(dataSource: $0) }).filter({ data in
            if let date = data.startDate {
                data.formatter.dateFormat = "yyyy-MM-dd"
                guard let compStartDate = data.formatter.date(from: date) else { return false }
                let compStartYear = data.calendar.component(.year, from: compStartDate)
                return data.currentYear-1 < compStartYear
            }
            return false
        })

        filteredData = data.sorted { $0.competitionName < $1.competitionName }
    }
}
