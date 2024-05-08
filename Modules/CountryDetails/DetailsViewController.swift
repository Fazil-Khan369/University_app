//
//  DetailsViewController.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import UIKit

protocol DetailsView: AnyObject {
    func updateWithUniversity(_ university: University)
}

class DetailsViewController: UIViewController {
    var presenter: DetailsViewOutput?
    var university: University?

    @IBOutlet weak var lblUniversity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblWebPage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Country Details"
        view.backgroundColor = .white
        
        if let university = university {
            lblUniversity.text = "Name: \(university.name)"
            lblState.text = "State: \(university.state)"
            lblState.isHidden = university.state.count == 0
            lblCountry.text = "Country: (\(university.countryCode)) \(university.country)"
            lblWebPage.text = "Webpage: \(university.webPage)"
        }
    }

    @objc func back() {
        presenter?.dismiss()
    }
}

extension DetailsViewController: DetailsView {
    func updateWithUniversity(_ university: University) {
        self.university = university
    }
}
