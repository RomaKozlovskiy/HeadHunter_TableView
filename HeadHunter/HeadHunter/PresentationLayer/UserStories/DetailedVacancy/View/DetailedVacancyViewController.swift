//
//  DetailedVacancyViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit
 
class DetailedVacancyViewController: UIViewController {
    
    var presenter: DetailedVacancyPresenterProtocol!
    private let stackView = UIStackView()
    private lazy var vacancyTitle: UILabel = _vacancyTitle
    private lazy var salaryLabel: UILabel = _salaryLabel
    private lazy var vacancyDescription: UILabel = _vacancyDescription
    private lazy var vacancyAddress: UILabel = _vacancyAddress
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        
        setStackViewConstraints()
        stackAddSubviews()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func stackAddSubviews() {
        if vacancyTitle.text != nil {
            stackView.addArrangedSubview(vacancyTitle)
        }
        stackView.addArrangedSubview(salaryLabel)
        stackView.addArrangedSubview(vacancyDescription)
        stackView.addArrangedSubview(vacancyAddress)
    }
    
}

// MARK: - DetailedVacancyViewProtocol

extension DetailedVacancyViewController: DetailedVacancyViewProtocol {
    
}

// MARK: - Private Extension

private extension DetailedVacancyViewController {
    var _vacancyTitle: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        result.backgroundColor = .green
        result.text = "TEST"
        result.numberOfLines = 0
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.backgroundColor = .yellow
        result.text = "TEST"
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _vacancyDescription: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.backgroundColor = .cyan
        result.text = "TEST"
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _vacancyAddress: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.backgroundColor = .systemPink
        result.text = "TEST"
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}
