//
//  CompetitionsList+CoreDataProperties.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/29/21.
//
//

import Foundation
import CoreData


extension CompetitionsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompetitionsList> {
        return NSFetchRequest<CompetitionsList>(entityName: "CompetitionsList")
    }

    @NSManaged public var competitionsID: Int16
    @NSManaged public var displayDate: String?
    @NSManaged public var competitionName: String?

}

extension CompetitionsList : Identifiable {

}
