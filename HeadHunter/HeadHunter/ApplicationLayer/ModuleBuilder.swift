//
//  ModuleBuilder.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit

protocol Builder {
    func createVacancyList() -> UIViewController
}

class ModuleBuilder: Builder {
    func createVacancyList() -> UIViewController {
        let networkClient = NetworkClient()
        let view = VacancyListViewController()
        let presenter = VacancyListPresenter(view: view, networkClient: networkClient)
        view.presenter = presenter
        return view
    }
}
