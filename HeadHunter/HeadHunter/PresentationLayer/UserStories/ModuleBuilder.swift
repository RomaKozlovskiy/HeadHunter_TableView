//
//  ModuleBuilder.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createVacancyList(router: RouterProtocol) -> UIViewController
    func createDetailedVacancy(with vacancyId: String?, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    func createVacancyList(router: RouterProtocol) -> UIViewController {
        let networkClient = NetworkClient()
        let view = VacancyListViewController()
        let presenter = VacancyListPresenter(view: view, router: router, networkClient: networkClient)
        view.presenter = presenter
        return view
    }
    
    func createDetailedVacancy(with vacancyId: String?, router: RouterProtocol) -> UIViewController {
        let networkClient = NetworkClient()
        let view = DetailedVacancyViewController()
        let presenter = DetailedVacancyPresenter(view: view, networkClient: networkClient, router: router, vacancyId: vacancyId)
        presenter.vacancyId = vacancyId
        view.presenter = presenter
        return view
    }
}
