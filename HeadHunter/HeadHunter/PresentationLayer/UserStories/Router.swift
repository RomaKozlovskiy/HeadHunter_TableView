//
//  Router.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit

protocol RouterMain: AnyObject {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailedVacancy(with vacancyId: String)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController?, moduleBuilder: ModuleBuilderProtocol?) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let vacancyListVC = moduleBuilder?.createVacancyList(router: self) else { return }
            navigationController.viewControllers = [vacancyListVC]
        }
    }
    
    func showDetailedVacancy(with vacancyId: String) {
        if let navigationController = navigationController {
            guard let detailedVacancyVC = moduleBuilder?.createDetailedVacancy(with: vacancyId, router: self) else { return }
            navigationController.pushViewController(detailedVacancyVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
