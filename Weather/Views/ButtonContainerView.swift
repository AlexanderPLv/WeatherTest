//
//  ButtoncontainerView.swift
//  Weather
//
//  Created by Alexander Pelevinov on 18.07.2021.
//

import UIKit

class ButtonContainerView: UIView {
    
    var buttonAction: (()->Void)?
    
    var addToFavoritesButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add To Favorites", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)),
                         for: .touchUpInside)
        return button
    }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(addToFavoritesButton)
            backgroundColor = .white
            addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
            [
                addToFavoritesButton.topAnchor.constraint(equalTo: topAnchor),
                addToFavoritesButton.leadingAnchor.constraint(equalTo: leadingAnchor) ,
                addToFavoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                addToFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            ].forEach { $0.isActive = true }
            
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    
        @objc func buttonTapped(_ sender: UIButton) {
            if let buttonAction = self.buttonAction {
                buttonAction()
            }
        }
    
}
