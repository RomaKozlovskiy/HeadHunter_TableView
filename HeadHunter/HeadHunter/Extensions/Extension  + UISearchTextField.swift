//
//  Extension  + UISearchTextField.swift
//  HeadHunter
//
//  Created by Роман Козловский on 18.11.2023.
//

import UIKit
import Combine

extension UISearchTextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UISearchTextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}
