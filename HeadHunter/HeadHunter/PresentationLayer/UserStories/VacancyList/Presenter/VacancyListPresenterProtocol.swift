//
//  VacancyListPresenterProtocol.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import Foundation

protocol VacancyListPresenterProtocol: AnyObject {
    var vacancyList: VacancyList? { get set }
    init(view: VacancyListViewProtocol, networkClient: NetworkClientProtocol)
    func fetchVacancyList(path: String, page: Int)
}
