//
//  ViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class TodaysFixturesViewController: UITableViewController, ResultHandler {
    
    var items = [TodaysFixturesViewModel]()
    var service: NetworkLoader?
    let spinner = SpinnerViewController()
    private var errorController = HandleFixtureListErrors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.start(container: Constants.topMostController())
        view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        loadFixtures()
        errorController.delegate = self
        self.setTableViewStyle(style: .grouped)
            .setTableViewInsets()
            
        self.tableView.registerTableViewCell(cell: TodaysFixturesTableViewCell.self)
    }
    
    private func loadFixtures() {
        service?.loadRequest(path: Constants.URLPaths.allFixtures, model: TodaysMatchesModel.self, completion: handleUrlRequest)
    }
    
    internal func handleUrlRequest(result: Result<TodaysMatchesModel, Error>) {
        switch result {
        case .success(let data):
            items = data.matches.map { TodaysFixturesViewModel(dataSource: $0) }
            spinner.stop()
            self.tableView.reloadData()
        case .failure(let error):
            spinner.stop()
            Constants.failureAlert(title: "Woops", viewController: self,
                                   text: error.localizedDescription, completion: { [weak self] _ in
                guard let self = self else { return }
                self.errorController.layoutEmptyView(container: self)
                self.errorController.service = self.service
            })

        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(with: TodaysFixturesTableViewCell.self,
                                                    indexPath: indexPath) as? TodaysFixturesTableViewCell {
            let cellData = items[indexPath.row]
            cell.configure(with: cellData)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension TodaysFixturesViewController: DataParser {
    func result(data: [TodaysFixturesViewModel]) {
        items = data
        self.tableView.reloadData()
    }
}
