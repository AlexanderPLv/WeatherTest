//
//  ReusableView.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
