//
//  ContainerPageViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class ContainerPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.smallTitle
        configureViews()
        configureTabView()
        configurePageViewSwipe()
        updateControllersAndTabsIfPossible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarHidden(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    var viewControllers: [UIViewController] = [] {
        didSet { updateControllersAndTabsIfPossible() }
    }
    
    private(set) var selectedIndex: Int = .zero {
        didSet { updateSelectedController(oldIndex: oldValue) }
    }
    
    let menu: MenuBarView = {
        let menu = MenuBarView()
        return menu
    }()
    
    let pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    func updateControllersAndTabsIfPossible() {
        viewControllers.forEach { $0.didMove(toParent: self) }
        updateSelectedController(oldIndex: selectedIndex, animated: false)
        updateTabsInView()
    }
    
    func configureViews() {
        let stackView = UIStackView(arrangedSubviews: [menu, pageController.view])
        stackView.axis = .vertical
        addChild(pageController)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        guard let navigationBar = self.navigationController?.navigationBar else { return }
        view.addSubview(menu)
        menu.frame = CGRect(x: 0, y: navigationBar.bottom, width: navigationBar.width, height: 60)
    }
    
    func configurePageViewSwipe() {
        pageController.view.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        pageController.view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
    
    func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        swipeGestureRecognizer.cancelsTouchesInView = false
        
        return swipeGestureRecognizer
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .left:
            swipeRightIfPossible()
        case .right:
            swipeLeftIfPossible()
        default: break
        }
    }
    
    func swipeRightIfPossible() {
        if selectedIndex < viewControllers.count - 1 {
            menu.selectItem(at: selectedIndex + 1)
        }
    }
    
    func swipeLeftIfPossible() {
        
        if selectedIndex > 0 {
            menu.selectItem(at: selectedIndex - 1)
        }
    }
    
    func configureTabView() {
        menu.configureSelectedMenuBar { [weak self] index in
            self?.selectedIndex = index
        }
    }
    
    func updateSelectedController(oldIndex: Int, animated: Bool = true) {
        let direction: UIPageViewController.NavigationDirection = oldIndex < selectedIndex ? .forward : .reverse
        selectViewController(direction: direction, animated: animated)
    }
    
    func selectViewController(direction: UIPageViewController.NavigationDirection, animated: Bool) {
        pageController.setViewControllers([viewControllers[selectedIndex]], direction: direction, animated: animated, completion: nil)
    }
    
    func updateTabsInView() {
        menu.setTabsList(viewControllers.map { $0.tabBarItem }, selectedIndex: nil)
        menu.selectItem(at: selectedIndex)
    }

}
