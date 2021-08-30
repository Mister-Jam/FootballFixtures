//
//  MenuBarCollectionViewCell.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/25/21.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func menuTapped(title: String)
}

class MenuBarCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MenuDelegate?
   
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tabViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var title: String? {
        get { tabViewButton.titleLabel?.text }
        set { tabViewButton.setTitle(newValue, for: .normal) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
        updatesViewOnClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet { updateViewAnimation() }
        
    }
    
    private func setupSubviews() {
    
        contentView.addMultipleSub(views: [tabViewButton, lineView])
        tabViewButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        tabViewButton.centerYAnchor(anchor: contentView.centerYAnchor)
            .centerXAnchor(anchor: contentView.centerXAnchor)
            .heightAnchorConstant(contentView.height-15)
            .widthAnchorConstant(contentView.width*0.8)

        lineView.widthAnchorConstant(contentView.width)
            .heightAnchorConstant(5)
            .centerXAnchor(anchor: contentView.centerXAnchor)
            .topAnchor(anchor: tabViewButton.bottomAnchor, constant: 5)
    }
    
    @objc func didTapMenuButton() {
        guard let title = title else { return }
        delegate?.menuTapped(title: String(describing: title))
    }
    
    private func updatesViewOnClick() {
        tabViewButton.setTitleColor(isSelected ? UIColor.black : UIColor.gray, for: .normal)
        lineView.backgroundColor = isSelected ? UIColor.black : .clear
    }
    
    private func updateViewAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.updatesViewOnClick()
        }
    }
    
    private func showAnimation() {
      UIView.animate(withDuration: 0.3) {
        self.tabViewButton.transform = CGAffineTransform(scaleX: 0.9,y: 0.9)
      }
    }
    
    private func hideAnimation() {
      UIView.animate(withDuration: 0.3) {
        self.tabViewButton.transform = CGAffineTransform.identity
      }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideAnimation()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideAnimation()
    }
}
