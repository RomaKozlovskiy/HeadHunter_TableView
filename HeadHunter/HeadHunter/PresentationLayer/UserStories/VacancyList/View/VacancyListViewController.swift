//
//  VacancyListViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 15.11.2023.
//

import UIKit
import Combine

class VacancyListViewController: UIViewController {

    // MARK: - Properties

    var presenter: VacancyListPresenterProtocol!
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private var cancellabels = Set<AnyCancellable>()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        setupSearchController()
        setupTableView()
        listenForSearchTextChanges()
    }
    
    // MARK: - Private Methods
  
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VacancyListCell.self, forCellReuseIdentifier: VacancyListCell.reuseID)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func listenForSearchTextChanges() {
        searchController.searchBar.searchTextField.textPublisher()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { (searchText) in
                if searchText.count >= 3 {
                    if self.presenter.vacancyList != nil {
                        self.presenter.vacancyList = nil
                    }
                    self.presenter.fetchVacancyList(path: searchText, page: 0)
                }
            }
            .store(in: &cancellabels)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension VacancyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.vacancyList?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VacancyListCell.reuseID, for: indexPath) as! VacancyListCell
        let vacancyList = presenter.vacancyList
        cell.setupWith(vacancyList: vacancyList, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let vacancyList = presenter.vacancyList else { return }
        if indexPath.row == vacancyList.items.count - 5 && vacancyList.items.count < vacancyList.pages {
            let path = searchController.searchBar.searchTextField.text ?? ""
            let page = (presenter.vacancyList?.page ?? 0 ) + 1
            presenter.fetchVacancyList(path: path , page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  vacancyId = presenter.vacancyList?.items[indexPath.row].id {
            presenter.didSelectVacancy(with: vacancyId)
        }
    }
}

// MARK: - VacancyListViewProtocol

extension VacancyListViewController: VacancyListViewProtocol {
    func successVacancyLoading() {
        tableView.reloadData()
    }
}
