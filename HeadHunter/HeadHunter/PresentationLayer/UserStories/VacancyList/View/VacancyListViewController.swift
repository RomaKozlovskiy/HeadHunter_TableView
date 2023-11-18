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
    }
    
    // MARK: - Private Methods
  
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Введите в поиск название вакансии"
        searchController.searchBar.searchTextField.textPublisher()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { (searchText) in
                if searchText.count >= 3 {
                    self.presenter.fetchVacancyList(path: searchText, page: 0)
                }
            }
            .store(in: &cancellabels)
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
}

// MARK: - VacancyListViewProtocol

extension VacancyListViewController: VacancyListViewProtocol {
    func successVacancyLoading() {
        tableView.reloadData()
    }
}
