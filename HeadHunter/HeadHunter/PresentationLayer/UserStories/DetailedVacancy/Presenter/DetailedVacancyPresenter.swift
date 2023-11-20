//
//  DetailedVacancyPresenter.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import Foundation

class DetailedVacancyPresenter: DetailedVacancyPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailedVacancyViewProtocol?
    private var router: RouterProtocol?
    private var networkClient: NetworkClientProtocol!
    private var detailedVacancy: DetailedVacancy?
    var vacancyId: String?
    
    // MARK: - init
    
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
    
    // MARK: - Public Methods
    
    func fetchDetailedVacancy() {
        networkClient.request(
            path: vacancyId ?? "",
            page: nil, method: .get,
            requestType: .detailedVacancy) { [weak self] (result: Result<DetailedVacancy?, Error>) in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let detailedVacancy):
                    strongSelf.detailedVacancy = detailedVacancy
                    DispatchQueue.main.async {
                        strongSelf.view?.showDetailedVacancy(detailedVacancy)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
