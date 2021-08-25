//
//  ViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

class TodaysFixturesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Today's Fixtures"
        tableView.rowHeight = UITableView.automaticDimension
        navigationController?.navigationBar.largeTitleTextAttributes = Constants.titleText
        
        self.setTableViewStyle(style: .grouped)
            .setTableViewInsets()
            
        self.tableView.registerTableViewCell(cell: TodaysFixturesTableViewCell.self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TodaysFixturesTableViewCell.self, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
}

