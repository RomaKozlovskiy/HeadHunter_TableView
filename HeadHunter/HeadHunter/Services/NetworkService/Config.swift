//
//  Config.swift
//  HeadHunter
//
//  Created by Роман Козловский on 16.11.2023.
//

import Foundation

struct NetworkConfig {
    private enum Key: String {
        case baseUrl
    }
    
    static var baseUrl: String {
        guard let baseUrl = Bundle.main.infoDictionary![Key.baseUrl.rawValue] as? String else {
            return "No value by key \(Key.baseUrl.rawValue)"
        }
        return baseUrl
    }
}
