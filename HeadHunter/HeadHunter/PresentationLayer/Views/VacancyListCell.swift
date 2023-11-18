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
    lazy var responsibilitiesLabel: UILabel = _responsibilitiesLabel
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        companyLogo.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
    }
    
    // MARK: - Public Methods
    
    func setupWith(vacancyList: VacancyList?, at index: Int) {
        let vacancy = vacancyList?.items[index]
        
        vacancyTitle.text = vacancy?.name
        
        if vacancy?.salary?.from != nil && vacancy?.salary?.to != nil {
            salaryLabel.text = "от \(vacancy?.salary?.from ?? 0) до \(vacancy?.salary?.to ?? 0) \(vacancy?.salary?.currency ?? "")"
        } else if vacancy?.salary?.from != nil && vacancy?.salary?.currency != nil {
            salaryLabel.text = "\(vacancy?.salary?.from ?? 0) \(vacancy?.salary?.currency ?? "")"
        } else {
            salaryLabel.text = "Заработная плата не указана"
        }
        
        companyName.text = vacancy?.employer?.name
        
        if vacancy?.snippet?.requirement != nil {
            requirementsLabel.text = "Требования: " + (vacancy?.snippet?.requirement ?? "")
        } else {
            requirementsLabel.text = ""
        }
        
        if vacancy?.snippet?.responsibility != nil {
            responsibilitiesLabel.text = "Обязанности: " + (vacancy?.snippet?.responsibility ?? "")
        } else {
            responsibilitiesLabel.text = ""
        }
       
        companyLogo.load(stringUrl: vacancy?.employer?.logoUrls?.original ?? "")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(vacancyTitle)
        addSubview(salaryLabel)
        addSubview(companyName)
        addSubview(companyLogo)
        addSubview(requirementsLabel)
        addSubview(responsibilitiesLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            vacancyTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            vacancyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vacancyTitle.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),
            vacancyTitle.heightAnchor.constraint(equalToConstant: 40),
            
            salaryLabel.topAnchor.constraint(equalTo: vacancyTitle.bottomAnchor, constant: 5),
            salaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            salaryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            companyName.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 5),
            companyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            companyName.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),
            companyName.heightAnchor.constraint(equalToConstant: 25),
            
            companyLogo.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            companyLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            companyLogo.heightAnchor.constraint(equalToConstant: 100),
            companyLogo.widthAnchor.constraint(equalToConstant: 100),
            
            requirementsLabel.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 5),
            requirementsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            requirementsLabel.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),

            responsibilitiesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            responsibilitiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            responsibilitiesLabel.topAnchor.constraint(equalTo: requirementsLabel.bottomAnchor, constant: 5),
            responsibilitiesLabel.trailingAnchor.constraint(equalTo: companyLogo.leadingAnchor, constant: -10),
        ])
    }
}

// MARK: - Private Extension

private extension VacancyListCell {
    var _vacancyTitle: UILabel {
        let result = UILabel()
        result.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        result.numberOfLines = 2
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
        result.numberOfLines = 2
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _companyLogo: UIImageView {
        let result = UIImageView()
        result.clipsToBounds = false
        result.image = UIImage(systemName: "person.crop.circle.badge.questionmark")
        result.layer.cornerRadius = 50
        result.clipsToBounds = true
        result.contentMode = .scaleAspectFit
        result.translatesAutoresizingMaskIntoConstraints = false

        return result
    }
    
    var _requirementsLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 13, weight: .light)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    var _responsibilitiesLabel: UILabel {
        let result = UILabel()
        result.numberOfLines = 2
        result.font = UIFont.systemFont(ofSize: 13, weight: .light)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}


