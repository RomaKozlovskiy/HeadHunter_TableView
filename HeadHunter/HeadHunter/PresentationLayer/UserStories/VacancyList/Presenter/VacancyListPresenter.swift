//
//  VacancyListPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import Foundation

class VacancyListPresenter: VacancyListPresenterProtocol {
 
    // MARK: - Properties
    
    weak var view: VacancyListViewProtocol?
    var router: RouterProtocol?
    private let networkClient: NetworkClientProtocol!
    var vacancyList: VacancyList?
    
    // MARK: - Init
    
    required init(view: VacancyListViewProtocol, router: RouterProtocol, networkClient: NetworkClientProtocol) {
        self.view = view
        self.router = router
        self.networkClient = networkClient
    }
    
    // MARK: - Public Methods
    
    func fetchVacancyList(path: String, page: Int) {
        networkClient.request(
            path: path,
            page: page,
            method: .get,
            requestType: .vacancyList) { [weak self] (result: Result<VacancyList?, Error>) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let vacancyList):
                        self?.vacancyList = vacancyList
                        strongSelf.view?.successVacancyLoading()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
