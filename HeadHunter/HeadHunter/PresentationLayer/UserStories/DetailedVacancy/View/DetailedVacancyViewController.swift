//
//  DetailedVacancyViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit

class DetailedVacancyViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: DetailedVacancyPresenterProtocol!
    private lazy var vacancyTitle: UILabel = _vacancyTitle
    private lazy var salaryLabel: UILabel = _salaryLabel
    private lazy var vacancyDescription: UILabel = _vacancyDescription
    private lazy var vacancyAddress: UILabel = _vacancyAddress
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        applyConstraints()
        presenter.fetchDetailedVacancy()
    }
    
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(vacancyTitle)
        stackView.addArrangedSubview(salaryLabel)
        stackView.addArrangedSubview(vacancyDescription)
        stackView.addArrangedSubview(vacancyAddress)
    }
    
    private func applyConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
    }
}

// MARK: - DetailedVacancyViewProtocol

extension DetailedVacancyViewController: DetailedVacancyViewProtocol {
    func showDetailedVacancy(_ detailedVacancy: DetailedVacancy?) {
        vacancyTitle.text = detailedVacancy?.name
        if detailedVacancy?.salary?.from != nil && detailedVacancy?.salary?.to != nil {
            salaryLabel.text = "от \(detailedVacancy?.salary?.from ?? 0) до \(detailedVacancy?.salary?.to ?? 0) \(detailedVacancy?.salary?.currency ?? "")"
        } else if detailedVacancy?.salary?.from != nil && detailedVacancy?.salary?.currency != nil {
            salaryLabel.text = "\(detailedVacancy?.salary?.from ?? 0) \(detailedVacancy?.salary?.currency ?? "")"
        } else {
            salaryLabel.text = "Заработная плата не указана"
        }
        vacancyDescription.text = detailedVacancy?.description
        vacancyDescription.attributedText = detailedVacancy?.description?.htmlToAttributedString
        vacancyAddress.text = detailedVacancy?.area?.name
    }
}

// MARK: - Private Extension

private extension DetailedVacancyViewController {
    
    var _vacancyTitle: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        result.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        result.textAlignment = .center
        result.numberOfLines = 0
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _vacancyDescription: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _vacancyAddress: UILabel {
        let result = UILabel()
        result.numberOfLines = 0
        result.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
}





