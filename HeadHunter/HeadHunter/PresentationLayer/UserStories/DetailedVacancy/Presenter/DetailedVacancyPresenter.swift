//
//  DetailedVacancyPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import Foundation

class DetailedVacancyPresenter: DetailedVacancyPresenterProtocol {
    
    weak var view: DetailedVacancyViewProtocol?
    var router: RouterProtocol?
    var networkClient: NetworkClientProtocol!
    var vacancyId: String?
    
    required init(
        view: DetailedVacancyViewProtocol,
        networkClient: NetworkClientProtocol,
        router: RouterProtocol,
        vacancyId: String?) {
            self.view = view
            self.networkClient = networkClient
            self.router = router
            self.vacancyId = vacancyId
        }
}
