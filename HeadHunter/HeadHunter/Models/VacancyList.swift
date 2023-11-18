//
//  VacancyList.swift
//  HeadHunter
//
//  Created by Роман Козловский on 17.11.2023.
//

import Foundation

struct VacancyList: Decodable {
    let items: [Item]
    let found: Int
    let pages: Int
    let perPage: Int
    let page: Int
    let alternateUrl: String
    
   private enum CodingKeys: String, CodingKey {
        case items
        case found
        case pages
        case perPage = "per_page"
        case page
        case alternateUrl = "alternate_url"
    }
}

struct Item: Decodable {
    let id: String?
    let name: String?
    let salary: Salary?
    let employer: Employer?
    let snippet: Snippet?
}

struct Salary: Decodable {
    let from: Int?
    let to: Int?
    let currency: String
    
//    enum Currency: String, Codable { //TODO: - может придется удалить enum
//        case byr = "BYR"
//        case kzt = "KZT"
//        case rur = "RUR"
//    }
}

struct Employer: Decodable {
    let id: String?
    let name: String?
    let logoUrls: LogoUrls?
    
    private enum CodingKeys: String, CodingKey {
       case id
       case name
       case logoUrls = "logo_urls"
    }
}

struct LogoUrls: Decodable {
    let the90: String?
    let the240: String?
    let original: String?
    
    private enum CodingKeys: String, CodingKey {
            case the90 = "90"
            case the240 = "240"
            case original
        }
}

struct Snippet: Decodable {
    let requirement: String?
    let responsibility: String?
}
