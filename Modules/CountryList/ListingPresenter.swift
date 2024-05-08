//
//  ListingPresenter.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import Foundation

protocol ListingViewOutput {
    func viewDidLoad()
    func didSelectUniversity(_ university: University)
    func refreshData()
}

class ListingPresenter: ListingViewOutput {
    var interactor: ListingInteractor?
    var router: ListingRouter?
    var view: ListingView?
    
    func viewDidLoad() {
        interactor?.fetchUniversities()
    }
    
    func didSelectUniversity(_ university: University) {
        router?.navigateToDetails(with: university)
    }
    
    func refreshData() {
        interactor?.fetchUniversities()
    }
}

extension ListingPresenter: ListingInteractorOutput {
    func didFetchUniversities(_ universities: [University]) {
        view?.updateWithUniversities(universities)
    }
    
    func didFailWithError(_ error: Error) {
        view?.showError("Failed to fetch data: \(error.localizedDescription)")
    }
}
