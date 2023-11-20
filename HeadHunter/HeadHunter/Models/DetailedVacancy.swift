//
//  DetailedVacancy.swift
//  HeadHunter
//
//  Created by Роман Козловский on 17.11.2023.
//

import Foundation

struct DetailedVacancy: Decodable {
    let id: String?
    let name: String?
    let salary: Salary?
    let description: String?
    let area: Area?
}

struct Area: Decodable {
    let name: String?
}
