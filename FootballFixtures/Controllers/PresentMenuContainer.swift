//
//  PresentMenuContainer.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/27/21.
//

import UIKit

protocol Presenter: AnyObject {
    func presentMenu(title: String, item: UINavigationItem, controller: UIViewController)
}

class PresentMenuContainer: Presenter {
    
    func presentMenu(title: String, item: UINavigationItem, controller: UIViewController) {
        let backItem = UIBarButtonItem()
        backItem.title = title
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
        let leagueTable = LeagueTableViewController()
        leagueTable.tabBarItem = UITabBarItem(title: Constants.Titles.table, image: .none, tag: 0)
        
        let leagueFixturesController = LeagueFixturesViewController()
        leagueFixturesController.tabBarItem = UITabBarItem(title: Constants.Titles.fixture,image: .none, tag: 1)
        
        let leagueTeamsViewController = LeagueTeamsViewController(collectionViewLayout: collectionLayout)
        leagueTeamsViewController.tabBarItem = UITabBarItem(title: Constants.Titles.teams,image: .none, tag: 2)
        
        let tabController = ContainerPageViewController()
        tabController.title = "Premier League"

        tabController.viewControllers = [leagueTable, leagueFixturesController, leagueTeamsViewController]
        
        return tabController
    }
    
    
}
