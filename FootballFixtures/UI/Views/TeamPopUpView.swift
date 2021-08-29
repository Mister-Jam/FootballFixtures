//
//  TeamPopUpView.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/26/21.
//

import UIKit

class TeamPopUpView: UIView {
    var tableData = [TeamPlayersListViewModel]()
    var headerImageUrl = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTableView()
    }
    
    let playersTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        return table
    }()
    
     func configureTableView() {
        addSubview(playersTableView)
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        playersTableView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        playersTableView.registerTableViewCell(cell: PlayersListTableViewCell.self)
    }
    
    func isLoaded() {
        self.playersTableView.tableHeaderView = self.createTableHeader()
    }
    
    
    func loadImage(imageView: UIImageView) {
        if let url = URL(string: headerImageUrl) {
            let svgImageSize = CGSize(width: 150, height: 150)
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "soccer"), options: [], context: [.imageThumbnailPixelSize : svgImageSize])
        } else {
            imageView.image = UIImage(named: "soccer")
        }
    }
    
    private func createTableHeader() -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height/5))
        header.backgroundColor = .clear

        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: header.height*0.8, height: header.height*0.8)
        imageView.center = header.center
        loadImage(imageView: imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        
        header.addSubview(imageView)
        return header
    }

}

extension TeamPopUpView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData.sorted {
            guard let playerA = $0.shirtNumber,
                  let playerB = $1.shirtNumber else { return false }
            return playerA < playerB }

        if let cell = tableView.dequeueReusableCell(with: PlayersListTableViewCell.self, indexPath: indexPath) as? PlayersListTableViewCell {
            cell.configure(with: data[indexPath.row])
        return cell
    }
        return UITableViewCell()
    }
}
