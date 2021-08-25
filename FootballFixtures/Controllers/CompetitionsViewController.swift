//
//  CompetitionsViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class CompetitionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Competitions"
        tableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        
        self.setTableViewStyle(style: .grouped)
            .setTableViewInsets()
        
        self.tableView.registerTableViewCell(cell: CompetitionsTableViewCell.self)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: CompetitionsTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
