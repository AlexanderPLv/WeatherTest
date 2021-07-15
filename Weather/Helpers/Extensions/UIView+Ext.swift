//
//  UIView+Ext.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        [
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
        ].forEach{ $0.isActive = true }
    }
}
