//
//  DetailsRouter.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import UIKit

class DetailsRouter {
    weak var viewController: DetailsViewController?

    func dismissDetails() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
