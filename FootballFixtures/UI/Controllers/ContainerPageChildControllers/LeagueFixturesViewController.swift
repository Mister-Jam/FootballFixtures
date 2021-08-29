//
//  LeagueFixturesViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueFixturesViewController: UIViewController, ResultHandler {
    
    var competitionID: String
    var service: NetworkLoader?
    private var matchesModel = [TodaysFixturesViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
        view.backgroundColor = .lightGray
    }
    
    init(id: String) {
        competitionID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        fixtureTable.dataSource = self
        fixtureTable.delegate = self
        fixtureTable.isHidden = matchesModel.count < 1
        emptyView.isHidden = matchesModel.count > 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadRequest() {
        let url = Constants.URLPaths.allCompetitions+competitionID+Constants.URLPaths.matches+Constants.URLPaths.matchFilterQuery
        service?.loadRequest(path: url, model: TodaysMatchesModel.self, completion: handleUrlRequest)
    }
    
    private let fixtureTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.isHidden = true
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.registerTableViewCell(cell: TodaysFixturesTableViewCell.self)
        return tableView
    }()
    
    internal func handleUrlRequest(result: Result<TodaysMatchesModel, Error>) {
        switch result {
        case .success(let data):
            matchesModel = data.matches.map { TodaysFixturesViewModel(dataSource: $0) }
            self.fixtureTable.reloadData()
            viewWillAppear(true)
        case .failure(let error):
            print(error)
        }
    }
    
    func configureView() {
        view.addMultipleSub(views: [fixtureTable, emptyView])
        emptyView.frame = CGRect(x: 0, y: view.height/4, width: view.width, height: view.height*0.5)
        fixtureTable.frame = view.bounds
    }
    
    private let emptyView: EmptyFixturesView = {
        let view = EmptyFixturesView()
        return view
    }()
}

extension LeagueFixturesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(with: TodaysFixturesTableViewCell.self, indexPath: indexPath) as? TodaysFixturesTableViewCell {
            cell.configure(with: matchesModel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
}
