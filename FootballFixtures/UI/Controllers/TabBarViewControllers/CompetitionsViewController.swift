//
//  CompetitionsViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class CompetitionsViewController: UITableViewController, ResultHandler {
    
    var presenter: Presenter
    var service: NetworkLoader?
    var items = [CompetitionsListViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension

        self.setTableViewStyle(style: .grouped)
            .setTableViewInsets()
        self.tableView.registerTableViewCell(cell: CompetitionsTableViewCell.self)
        
        service?.loadRequest(path: Constants.URLPaths.allCompetitions,
                             model: CompetitionsListModel.self, completion: handleUrlRequest)
    }
    
    init(controller: Presenter) {
        presenter = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func handleUrlRequest(result: Result<CompetitionsListModel, Error>) {
        switch result {
        case .success(let data):
            items = FilterReturnedApiData(apiData: data.competitions).filteredData
            self.tableView.reloadData()
        case .failure(let error):
            Constants.failureAlert(viewController: self, text: error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarHidden(false)
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(with: CompetitionsTableViewCell.self,
                                                    indexPath: indexPath) as? CompetitionsTableViewCell {
            cell.configure(with: cellItem)
            return cell
        }
 
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellData = items[indexPath.row]
        presenter.presentController(title: cellData.displayText(), id: "\(cellData.competitionId)", item: self.navigationItem, controller: self, url: nil)
    }
}
