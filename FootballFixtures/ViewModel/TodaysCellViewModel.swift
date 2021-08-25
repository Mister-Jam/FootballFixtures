//
//  TodaysCellViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import Foundation

protocol CellInputsIO {
    associatedtype Model
    var cellData: Model? { set get }
}


