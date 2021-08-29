//
//  LeagueStandingList+CoreDataProperties.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/29/21.
//
//

import Foundation
import CoreData


extension LeagueStandingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeagueStandingList> {
        return NSFetchRequest<LeagueStandingList>(entityName: "LeagueStandingList")
    }

    @NSManaged public var teamPosition: Int16
    @NSManaged public var teamLogoUrl: String?
    @NSManaged public var teamName: String?
    @NSManaged public var matchesPlayed: Int16
    @NSManaged public var goalDifference: Int16
    @NSManaged public var totalPoints: Int16
    @NSManaged public var teamID: Int16

}

extension LeagueStandingList : Identifiable {

}
