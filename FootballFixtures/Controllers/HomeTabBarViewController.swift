//
//  HomeTabBarViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBars()
    }
    
    
    func setupTabBars() {
        let todaysFixturesTabBar       = TodaysFixturesViewController()
        let competitionsTabBar         = CompetitionsViewController()
        
        
        let todaysFixturesHome         = UINavigationController(rootViewController: todaysFixturesTabBar)
        let competitionsHome           = UINavigationController(rootViewController: competitionsTabBar)
        
        todaysFixturesHome.tabBarItem  = UITabBarItem(title: "", image: UIImage(named: "soccer"), tag: 0)
        competitionsHome.tabBarItem    = UITabBarItem(title: "", image: UIImage(named: "soccer-field"), tag: 1)
        
        tabBar.barTintColor         = .white
        tabBar.tintColor            = .black
        
        todaysFixturesHome.navigationBar.prefersLargeTitles    = true
        competitionsHome.navigationBar.prefersLargeTitles  = true
        
        setViewControllers([todaysFixturesHome, competitionsHome], animated: true)
    }
    
    
}
