//
//  PresentMenuContainer.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import UIKit

protocol Presenter: AnyObject {
    func presentController(title: String, id: String, item: UINavigationItem, controller: UIViewController)
}

class PresentMenuContainer: Presenter {
    var navTitle = ""
    var competitionId = ""
    let adapter = NetworkAdapter(networkService: .shared)
    let playersPresenter: Presenter = PresentPlayersVC()
    
    func presentController(title: String, id: String, item: UINavigationItem, controller: UIViewController) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navTitle = title
        competitionId = id
        item.backBarButtonItem = backItem
        controller.show(configureViewControllers(), sender: self)
    }
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private func configureViewControllers () -> ContainerPageViewController {
        let leagueTable = LeagueStandingsViewController(id: competitionId)
        leagueTable.tabBarItem = UITabBarItem(title: Constants.Titles.table, image: .none, tag: 0)
        leagueTable.service = adapter
        
        let leagueFixturesController = LeagueFixturesViewController(id: competitionId)
        leagueFixturesController.tabBarItem = UITabBarItem(title: Constants.Titles.fixture,image: .none, tag: 1)
        leagueFixturesController.service = adapter
    
        
        let leagueTeamsViewController = LeagueTeamsViewController(collectionViewLayout: collectionLayout)
        leagueTeamsViewController.presenter = playersPresenter
        leagueTeamsViewController.tabBarItem = UITabBarItem(title: Constants.Titles.teams,image: .none, tag: 2)
        leagueTeamsViewController.service = adapter
        
        let tabController = ContainerPageViewController()
        tabController.title = navTitle

        tabController.viewControllers = [leagueTable, leagueFixturesController, leagueTeamsViewController]
        
        return tabController
    }
}


class PresentPlayersVC: Presenter {
    var teamID = ""
    var adapter = NetworkManager.shared
    
    func presentController(title: String, id: String, item: UINavigationItem, controller: UIViewController) {
        teamID = id
        item.title = title
        controller.show(configureController(), sender: self)
    }
    
    func configureController() -> UIViewController {
        let playersVC =  PlayersListViewController(id: teamID)
        let vc = UINavigationController(rootViewController: playersVC)
        vc.isModalInPresentation = true
        playersVC.service = adapter
        return vc
    }
}
