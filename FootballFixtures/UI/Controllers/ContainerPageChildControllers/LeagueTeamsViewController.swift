//
//  LeagueTeamsViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class LeagueTeamsViewController: UICollectionViewController, ResultHandler {

    var playersModel = [TeamSquadModel]()
    var service: NetworkLoader?
    var presenter: Presenter?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCollectionViewCell(cell: LeagueTeamsCollectionViewCell.self)
        collectionView.backgroundColor = .white
        
    }
    
    internal func handleUrlRequest(result: Result<TeamSquadModel, Error>) {
        switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 5, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: LeagueTeamsCollectionViewCell.self, indexPath: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.presentController(title: "Manchester United", id: "66", item: self.navigationItem, controller: self)
        
    }
}

extension LeagueTeamsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        return CGSize(width: (view.width-insets)/3, height: view.height/4)
    }
}
