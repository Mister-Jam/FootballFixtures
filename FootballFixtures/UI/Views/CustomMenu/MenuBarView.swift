//
//  MenuBarView.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

class MenuBarView: UIView {
    
    private var selection: ((Int) -> Void)?
    private var tabItems: [UIBarItem] = []
    private var selectedTabIndex: Int? {
        didSet {
            if let tabIndex = selectedTabIndex {
                selection?(tabIndex)
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCollectionViewCell(cell: MenuBarCollectionViewCell.self)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MenuBarView {
    
    func selectItem(at index: Int, animated: Bool = false) {
      self.selectedTabIndex = index
      let indexPath = IndexPath(row: index, section: .zero)
      DispatchQueue.main.async {
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
      }
    }
    
    func setTabsList (_ items: [UIBarItem], selectedIndex: Int?) {
        tabItems = items
    }
    
    func configureSelectedMenuBar(selection: @escaping ((Int) -> Void)) {
        self.selection = selection
    }
    
    func configureTabCell(cell: MenuBarCollectionViewCell, index: IndexPath) {
        let item = tabItems[index.row]
        cell.title = item.title
        cell.isSelected = index.item == selectedTabIndex
    }
}

extension MenuBarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(with: MenuBarCollectionViewCell.self, indexPath: indexPath) as? MenuBarCollectionViewCell {
            configureTabCell(cell: cell, index: indexPath)
             return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTabIndex = indexPath.item
        print("selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (self.width/CGFloat(tabItems.count)), height: self.height)
    }
}

