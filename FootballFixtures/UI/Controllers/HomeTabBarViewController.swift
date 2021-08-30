//
//  HomeTabBarViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    var competitionsSelector: Presenter = PresentMenuContainer()
    let adapter = NetworkAdapter(networkService: .shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBars()
    }
    
    
    private func setupTabBars() {

        let todaysFixturesHome         = makeFixtureController()
        let competitionsHome           = makeCompetitionController()
        
        todaysFixturesHome.tabBarItem  = UITabBarItem(title: "", image: UIImage(named: Constants.Images.ball), tag: 0)
        competitionsHome.tabBarItem    = UITabBarItem(title: "", image: UIImage(named: Constants.Images.field), tag: 1)
        
        tabBar.barTintColor         = .white
        tabBar.tintColor            = .black
        
        setViewControllers([todaysFixturesHome, competitionsHome], animated: true)
    }
    
    private func makeFixtureController() -> UINavigationController  {
        let todaysFixtureVC = TodaysFixturesViewController()
        todaysFixtureVC.service = adapter
        return configureViewController(todaysFixtureVC)
    }
    
    private func makeCompetitionController() -> UINavigationController  {
        let competitionsVc = CompetitionsViewController(controller: competitionsSelector)
        competitionsVc.service = adapter
        return configureViewController(competitionsVc)
    }
    
    private func configureViewController (_ controller: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationItem.largeTitleDisplayMode = .always
        return navController
    }
}
