//
//  CustomError.swift
//  HeadHunter
//
//  Created by Роман Козловский on 16.11.2023.
//

import Foundation

class CustomError: Error {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
