//
//  DetailedVacancyPresenterProtocol.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import Foundation

protocol DetailedVacancyPresenterProtocol: AnyObject {
    var vacancyId: String? { get set }
    init(
        view: DetailedVacancyViewProtocol,
        networkClient: NetworkClientProtocol,
        router: RouterProtocol,
        vacancyId: String?
    )
    func fetchDetailedVacancy()
}
