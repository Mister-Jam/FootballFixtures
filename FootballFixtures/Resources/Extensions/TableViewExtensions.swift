//
//  TableViewExtensions.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/24/21.
//

import UIKit

extension UITableView {
    
    func setTableViewInsets() {
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
    }
    
    func registerTableViewCell(cell: UITableViewCell.Type) {
        let identifier = String(describing: cell)
        self.register(cell, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(with cell: UITableViewCell.Type, indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: cell)
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

extension UITableViewController {
    @discardableResult
    func setTableViewStyle(style: UITableView.Style) -> UITableView {
        self.tableView = UITableView(frame: .zero, style: style)
        return tableView
    }
    
}
