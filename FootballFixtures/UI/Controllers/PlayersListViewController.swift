//
//  PlayersListViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/26/21.
//

import UIKit

class PlayersListViewController: UIViewController, ResultHandler {
    
    private var playersListModelData = [TeamPlayersListViewModel]()
    var service: NetworkLoader?
    var teamID: String
    var logoUrl: String
    var navigationTitle: String
    private var swippedUp = false
    
    init(id: String, urlString: String, title: String) {
        self.teamID = id
        self.logoUrl = urlString
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeGestures()
        view.backgroundColor = .clear
        navigationItem.leftBarButtonItem =  menuListBarButtonItem()
        navigationController?.navigationBar.tintColor = .black
        let urlPath = Constants.URLPaths.teams+teamID
        service?.loadRequest(path: urlPath, model: TeamSquadModel.self, completion: handleUrlRequest)
    }
    
    internal func handleUrlRequest(result: Result<TeamSquadModel, Error>) {
        switch result {
        case .success(let data):
            playersListModelData = data.squad.map { TeamPlayersListViewModel(dataSource: $0) }
            popupView.tableData = playersListModelData
            DispatchQueue.main.async { [weak self] in
                self?.popupView.playersTableView.reloadData() }
        case .failure(let error):
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = navigationTitle
        configureViewAppear()
    }
    
    func menuListBarButtonItem () -> UIBarButtonItem {
       UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissView))
   }
    
    private func configureViewAppear() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(popupView)
        popupView.headerImageUrl = logoUrl
        popupView.frame = CGRect(x: 0, y: view.height/2, width: view.width, height: view.height)
    }
    
    func addSwipeGestures() {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(upGestureAction))
        upGesture.direction = .up
        navigationController?.view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(upGesture)
        popupView.addGestureRecognizer(upGesture)
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        downGesture.direction = .down
        navigationController?.view.addGestureRecognizer(downGesture)
        view.addGestureRecognizer(downGesture)
        popupView.addGestureRecognizer(downGesture)
        popupView.playersTableView.addGestureRecognizer(downGesture)
        popupView.playersTableView.tableHeaderView?.addGestureRecognizer(downGesture)
    }
    
    private let popupView: TeamPopUpView = {
        let popupView = TeamPopUpView()
        popupView.playersTableView.isScrollEnabled = false
        return popupView
    }()
    
    func isUp() { }
    
    func isDown() {
        self.swippedUp = true
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.popupView.frame = CGRect(x: 0, y: 0, width: self?.view.width ?? 0, height: self?.view.height ?? 0)
            self?.navigationController?.navigationBar.isHidden = false
            self?.view.reloadInputViews()
            self?.view.layoutIfNeeded()
            self?.popupView.playersTableView.isScrollEnabled = true
        })
    }
    
    @objc func upGestureAction() {
        swippedUp ? isUp() : isDown()
    }
    
    @objc func dismissView() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.swippedUp = false
            self?.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
}
