//
//  ListingViewController.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import UIKit

protocol ListingView {
    func updateWithUniversities(_ universities: [University])
    func showError(_ message: String)
}

class ListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var presenter: ListingViewOutput?
    var universities: [University] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Universities in UAE"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        setPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    func setPresenter() {
        
        let presenter = ListingPresenter()
        let interactor = ListingInteractor()
        let router = ListingRouter()

        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = self
    }

    @objc func refresh() {
        showActivityIndicator()
        presenter?.refreshData()
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingViewCell", for: indexPath) as? ListingViewCell
        cell?.lblName.text = universities[indexPath.row].name
        cell?.lblState.text = universities[indexPath.row].state
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectUniversity(universities[indexPath.row])
    }
}

extension ListingViewController: ListingView {
    func updateWithUniversities(_ universities: [University]) {
        self.universities = universities
        tableView.reloadData()
        hideActivityIndicator()
    }

    func showError(_ message: String) {
        hideActivityIndicator()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
