//
//  DetailsEntity.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import UIKit

class DetailsModuleBuilder {
    static func buildDetailsModule(with university: University) -> DetailsViewController {
        let viewController = UIStoryboard(name: "DetailView", bundle: Bundle.main).instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        let presenter = DetailsPresenter()
        let router = DetailsRouter()

        viewController.presenter = presenter
        viewController.university = university
        presenter.view = viewController
        presenter.router = router
        router.viewController = viewController

        return viewController
    }
}
