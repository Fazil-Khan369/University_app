//
//  ListingEntity.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import RealmSwift

class University: Object {
    @Persisted var name: String = ""
    @Persisted var state: String = ""
    @Persisted var country: String = ""
    @Persisted var countryCode: String = ""
    @Persisted var webPage: String = ""
}

class ListingModuleBuilder {
    static func buildListingModule() -> ListingViewController {
        let viewController = ListingViewController()
        let presenter = ListingPresenter()
        let interactor = ListingInteractor()
        let router = ListingRouter()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = viewController

        return viewController
    }
}
