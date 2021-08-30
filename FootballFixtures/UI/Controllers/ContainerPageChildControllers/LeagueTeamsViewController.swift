//
//  LeagueTeamsViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueTeamsViewController: UICollectionViewController {

    var teamsData = [LeagueTeamsViewModel]()
    var presenter: Presenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCollectionViewCell(cell: LeagueTeamsCollectionViewCell.self)
        collectionView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let data = LeagueTeamsViewModel.leagueTeamsData
        teamsData = data.map { LeagueTeamsViewModel(dataSource: $0)}
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 5, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamsData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = teamsData[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(with: LeagueTeamsCollectionViewCell.self, indexPath: indexPath) as? LeagueTeamsCollectionViewCell {
            cell.configure(with: item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = teamsData[indexPath.row]
        presenter?.presentController(title: item.teamName, id: "\(item.teamID)", item: self.navigationItem, controller: self, url: item.teamLogoUrl)
        
    }
}

extension LeagueTeamsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        return CGSize(width: (view.width-insets)/3, height: view.height/4)
    }
}
