//
//  DetailsPresenter.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import Foundation

protocol DetailsViewOutput {
    func dismiss()
}

class DetailsPresenter: DetailsViewOutput {
    var router: DetailsRouter?
    var view: DetailsView?

    func dismiss() {
        router?.dismissDetails()
    }
}

