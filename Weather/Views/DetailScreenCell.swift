//
//  DetailScreenCell.swift
//  Weather
//
//  Created by Alexander Pelevinov on 18.07.2021.
//

import UIKit

class DetailScreenCell: UITableViewCell, ReusableView {
       
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let parameterLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.contentMode = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ title : String) {
        titleLabel.text = title
    }
    
    func set(parameter: String) {
        parameterLabel.text = parameter
    }

    private func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, parameterLabel])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ].forEach { $0.isActive = true }
    }
    
}


