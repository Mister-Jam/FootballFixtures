//
//  FootballFixturesTests.swift
//  FootballFixturesTests
//
//  Created by King Bileygr on 8/24/21.
//

import XCTest
@testable import FootballFixtures

class FootballFixturesTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func test_tabBarHasTwoControllers() {
        XCTAssertEqual(HomeTabBarViewController().viewControllers?.count, 2)
    }
    
    func test_FixtureControllerHasRightTitle() throws {
        let sut = try getFirsTabController()
        sut.loadViewIfNeeded()
        XCTAssertNil(sut.title, "Today's Fixtures")
    }

    func test_controllerHasDatasourceAndDelegate() throws {
        let sut = try getFirsTabController()
        XCTAssertNotNil(sut.tableView.dataSource, "datasource test")
        XCTAssertNotNil(sut.tableView.delegate, "delegate test")
        
        let secSut = try getSecondTabController()
        XCTAssertNotNil(secSut.tableView.dataSource, "competitions datasource")
        XCTAssertNotNil(secSut.tableView.delegate, "competitions delegate")
    }
    
    func test_tableStartsEmpty() throws {
        let sut = try getSecondTabController()
        XCTAssertTrue(sut.tableView.numberOfRows(inSection: 0) == 0)
    }
    
    
    func getFirsTabController() throws-> TodaysFixturesViewController {
        let navigation = try XCTUnwrap(HomeTabBarViewController().viewControllers?.first as? UINavigationController)
        let sut = try XCTUnwrap(navigation.topViewController as? TodaysFixturesViewController)
        sut.service = MockAdapter(service: MockNetwork())
        return sut
    }
    
    func getSecondTabController() throws-> CompetitionsViewController {
        let navigation = try XCTUnwrap(HomeTabBarViewController().viewControllers?.last as? UINavigationController)
        let sut = try XCTUnwrap(navigation.viewControllers.last as? CompetitionsViewController)
        sut.service = MockAdapter(service: MockNetwork())
        return sut
    }

}
class MockNetwork: NetworkLoader {
    func loadRequest<T>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        let score = FullTime(homeTeam: 2, awayTeam: 2)
        let ftScore = Score(fullTime: score)
        let team1 = Team(id: 1, name: "Man U")
        let team2 = Team(id: 1, name: "Away Team")
        let firstData = Matches(utcDate: "2021-12-08", matchday: 4, score: ftScore, homeTeam: team1, awayTeam: team2)
        let secondData = Matches(utcDate: "2021-12-08", matchday: 4, score: ftScore, homeTeam: team1, awayTeam: team2)
        var model1 = [Matches]()
        model1.append(firstData)
        model1.append(secondData)
    }
}

struct MockAdapter: NetworkLoader {
    var service: MockNetwork
    func loadRequest<T>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        service.loadRequest(path: path, model: model) { result in
            completion(result)
        }
    }
}

