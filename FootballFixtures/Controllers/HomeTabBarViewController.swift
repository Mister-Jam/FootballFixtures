//
//  HomeTabBarViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    var competitionsSelector: Presenter = PresentMenuContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBars()
    }
    
    
    private func setupTabBars() {
        let todaysFixturesHome         = configureViewController(TodaysFixturesViewController())
        let competitionsHome           = configureViewController(CompetitionsViewController(controller: competitionsSelector))
        
        todaysFixturesHome.tabBarItem  = UITabBarItem(title: "", image: UIImage(named: Constants.Images.ball), tag: 0)
        competitionsHome.tabBarItem    = UITabBarItem(title: "", image: UIImage(named: Constants.Images.field), tag: 1)
        
        tabBar.barTintColor         = .white
        tabBar.tintColor            = .black
        
        setViewControllers([todaysFixturesHome, competitionsHome], animated: true)
    }
    
    private func configureViewController (_ controller: UIViewController) -> UINavigationController {
        controller.navigationItem.largeTitleDisplayMode = .always
        let navController = UINavigationController(rootViewController: controller)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationItem.largeTitleDisplayMode = .always
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        return navController
    }
}
