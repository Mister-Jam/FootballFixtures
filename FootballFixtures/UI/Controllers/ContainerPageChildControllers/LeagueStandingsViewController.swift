//
//  LeagueTableViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueStandingsViewController: UITableViewController, ResultHandler {

    var service: NetworkLoader?
    var competitionsId: String
    var teamStandingsArray = [LeagueStandingsViewModel]()
    let spinner = SpinnerViewController()
    
    init(id: String) {
        competitionsId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.start(container: self)
        loadRequest()
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        self.setTableViewStyle(style: .grouped)
            .setTableViewInsets()
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.registerTableViewCell(cell: LeagueTableViewCell.self)
    }
    
    private func loadRequest() {
        let urlPath = Constants.URLPaths.allCompetitions+competitionsId+Constants.URLPaths.standings
        service?.loadRequest(path: urlPath, model: LeagueTableStandingsModel.self, completion: handleUrlRequest)
    }
    
    internal func handleUrlRequest(result: Result<LeagueTableStandingsModel, Error>) {
        switch result {
        case .success(let data):
            let teamsTable = transformData(data: data.standings)
            teamStandingsArray = teamsTable.map { LeagueStandingsViewModel(dataSource: $0) }

            spinner.stop()
            self.tableView.reloadData()
        case .failure(let error):
            spinner.stop()
            Constants.failureAlert(title: "This is Awkward", viewController: self,
                                   text: error.localizedDescription, completion: {[weak self] _ in
                                    guard let self = self else { return }
                                    self.navigationController?.popViewController(animated: true)
                                   })
        }
    }
    
    internal func transformData(data: [TableStandings]) -> [TeamTable] {
        var result = [TeamTable]()
        _ = data.map { result.append(contentsOf: $0.table) }
        LeagueTeamsViewModel.leagueTeamsData = result.map { $0.team }
        return result
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamStandingsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(with: LeagueTableViewCell.self, indexPath: indexPath) as? LeagueTableViewCell {
            let item = teamStandingsArray[indexPath.row]
            cell.configure(with: item)
        return cell
        }
        return UITableViewCell()
    }
}


