//
//  JsonDecodeHelper.swift
//  HeadHunter
//
//  Created by Роман Козловский on 16.11.2023.
//

import Foundation

class JsonDecodeHelper {
    static let shared: JsonDecodeHelper = JsonDecodeHelper()
    private let jsonDecoder = JSONDecoder()
    
    private init() {}
    
    func decode<T: Decodable>(data: Data?, type: T.Type) -> T? {
        if let data = data {
           return try? jsonDecoder.decode(type, from: data)
        } else {
            return nil
        }
    }
}
