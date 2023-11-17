//
//  VacancyListCell.swift
//  HeadHunter
//
//  Created by Роман Козловский on 17.11.2023.
//

import UIKit

class VacancyListCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseID = "VacancyListCell"
    
    lazy var vacancyTitle: UILabel = _vacancyTitle
    lazy var salaryLabel: UILabel = _salaryLabel
    lazy var companyName: UILabel = _companyName
    lazy var companyLogo: UIImageView = _companyLogo
    lazy var requirementsLabel: UILabel = _requirementsLabel
    lazy var responsibilities: UILabel = _responsibilities
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(vacancyTitle)
        addSubview(salaryLabel)
        addSubview(companyName)
        addSubview(companyLogo)
        addSubview(requirementsLabel)
        addSubview(responsibilities)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            vacancyTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            vacancyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vacancyTitle.heightAnchor.constraint(equalToConstant: 25),
            
            salaryLabel.topAnchor.constraint(equalTo: vacancyTitle.bottomAnchor, constant: 5),
            salaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            salaryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            companyName.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 5),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            companyName.heightAnchor.constraint(equalToConstant: 25),
            
            companyLogo.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            companyLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            companyLogo.heightAnchor.constraint(equalToConstant: 100),
            companyLogo.widthAnchor.constraint(equalToConstant: 100),
            
            requirementsLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 5),
            requirementsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            requirementsLabel.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),
            
            responsibilities.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            responsibilities.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            responsibilities.topAnchor.constraint(equalTo: requirementsLabel.bottomAnchor, constant: 5),
            responsibilities.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),
        ])
    }
}

// MARK: - Private Extension

private extension VacancyListCell {
    var _vacancyTitle: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _salaryLabel: UILabel {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _companyName: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _companyLogo: UIImageView {
        let result = UIImageView()
        result.clipsToBounds = false
        result.image = UIImage(systemName: "doc.fill")
        result.layer.cornerRadius = 50
        result.clipsToBounds = true
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _requirementsLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _responsibilities: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}
