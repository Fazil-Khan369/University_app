//
//  ListingInteractor.swift
//  TestTask
//
//  Created by Fazil P on 08/05/2024.
//

import Foundation
import Alamofire
import RealmSwift

protocol ListingInteractorOutput {
    func didFetchUniversities(_ universities: [University])
    func didFailWithError(_ error: Error)
}

class ListingInteractor {
    var output: ListingInteractorOutput?
    private let realm = try! Realm()
    
    func fetchUniversities() {
        let url = "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates"
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                // Parse data and store in Realm
                guard let universitiesData = data as? [[String: Any]] else { return }
                var universities = [University]()
                try! self.realm.write {
                    for universityData in universitiesData {
                        let university = University()
                        university.name = universityData["name"] as? String ?? ""
                        university.state = universityData["state-province"] as? String ?? ""
                        university.country = universityData["country"] as? String ?? ""
                        university.countryCode = universityData["alpha_two_code"] as? String ?? ""
                        university.webPage = (universityData["web_pages"] as? [String] ?? []).first ?? ""
                        universities.append(university)
                        self.realm.add(university)
                    }
                }
                self.output?.didFetchUniversities(universities)
            case .failure(let error):
                // Load data from Realm
                let cachedUniversities = Array(self.realm.objects(University.self))
                if !cachedUniversities.isEmpty {
                    self.output?.didFetchUniversities(cachedUniversities)
                } else {
                    self.output?.didFailWithError(error)
                }
            }
        }
    }
}
