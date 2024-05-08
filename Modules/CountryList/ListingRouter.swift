//
//  ListingRouter.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import UIKit

class ListingRouter {
    weak var viewController: ListingViewController?
    
    func navigateToDetails(with university: University) {
        let detailsViewController = DetailsModuleBuilder.buildDetailsModule(with: university)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
