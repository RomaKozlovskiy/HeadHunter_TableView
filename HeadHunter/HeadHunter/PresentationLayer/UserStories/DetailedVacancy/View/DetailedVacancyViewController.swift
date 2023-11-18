//
//  DetailedVacancyViewController.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit
 
class DetailedVacancyViewController: UIViewController {
    
    var presenter: DetailedVacancyPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    }
    

}

// MARK: - DetailedVacancyViewProtocol

extension DetailedVacancyViewController: DetailedVacancyViewProtocol {
    
}
