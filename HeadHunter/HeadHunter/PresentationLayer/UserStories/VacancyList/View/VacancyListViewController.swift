//
//  VacancyListViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 15.11.2023.
//

import UIKit

class VacancyListViewController: UIViewController {

    // MARK: - Properties
   
    var presenter: VacancyListPresenterProtocol!
    private let tableView = UITableView()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        presenter.fetchVacancyList(path: "Программист", page: 0)
        setupTableView()
    }
    
    // MARK: - Private Methods
    
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
