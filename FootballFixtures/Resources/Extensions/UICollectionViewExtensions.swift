//
//  UICollectionViewExtensions.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

extension UICollectionView {
    func registerCollectionViewCell(cell: UICollectionViewCell.Type) {
        let identifier = String(describing: cell)
        self.register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(with cell: UICollectionViewCell.Type, indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: cell)
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}
