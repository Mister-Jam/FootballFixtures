//
//  TodaysCellViewModel.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import Foundation

protocol ConfigureWithViewModel: AnyObject {
    associatedtype ViewModel
    func configure(with model: ViewModel)
}


protocol DataParser: AnyObject {
    func result(data: [TodaysFixturesViewModel])
}
