//
//  ErrorViewController.swift
//  FootballFixtures
//
//  Created by King Bileygr on 8/29/21.
//

import UIKit


class HandleFixtureListErrors: UIViewController, ResultHandler {
    
    var spinner = UIActivityIndicatorView(style: .large)
    var service: NetworkLoader?
    weak var delegate: DataParser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addMultipleSub(views: [fixtureView, spinner])
        fixtureView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        fixtureView.retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        spinner.frame = CGRect(x: (view.width-200)/2, y: (view.height-300)/3, width: 200, height: 200)
    }
    
    @objc func didTapRetry() {
        spinner.color = .black
        spinner.startAnimating()
        service?.loadRequest(path: Constants.URLPaths.allFixtures, model: TodaysMatchesModel.self, completion: handleUrlRequest)
    }
    
    internal func handleUrlRequest(result: Result<TodaysMatchesModel, Error>) {
        switch result {
        case .success(let data):
            let items = data.matches.map { TodaysFixturesViewModel(dataSource: $0) }
            delegate?.result(data: items)
            self.removeFromContainer()
        case .failure(let error):
            spinner.stopAnimating()
            Constants.failureAlert(viewController: self, text: error.localizedDescription)
        }
    }
    
    public func layoutEmptyView(container: UIViewController) {
        container.addChild(self)
        self.view.frame         = container.view.frame
        container.view.addSubview(self.view)
        self.didMove(toParent: container)
    }
    
    private func removeFromContainer() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private var fixtureView: EmptyFixturesView = {
        let view = EmptyFixturesView()
        view.retryButton.backgroundColor = .darkGray
        view.retryButton.titleLabel?.font = .systemFont(ofSize: 20)
        return view
    }()

}
