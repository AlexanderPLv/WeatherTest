//
//  WeatherTableCell.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import UIKit

class WeatherTableCell: UITableViewCell, ReusableView {
    
    private let conditionImage = UIImageView()
       
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.contentMode = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 50)
        label.contentMode = .center
        return label
    }()
    
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ weatherData: CityInfo) {
        cityLabel.text = weatherData.geoInfo.cityName
        setTempLabel(with: weatherData.weather.temp)
        setImage(by: weatherData.weather.condition)
    }
    
    private func setImage(by condition: Condition) {
        switch condition {
        case .clear:
            conditionImage.image = #imageLiteral(resourceName: "sunny")
        case .cloudy, .overcast, .partlyCloudy:
            conditionImage.image = #imageLiteral(resourceName: "cloudy")
        case .continuousHeavyRain, .heavyRain, .rain, .moderateRain, .showers, .hail:
            conditionImage.image = #imageLiteral(resourceName: "rain")
        case .drizzle, .lightRain:
            conditionImage.image = #imageLiteral(resourceName: "drizzle")
        case .wetSnow, .lightSnow, .snow, .snowShowers:
            conditionImage.image = #imageLiteral(resourceName: "snow")
        case .thunderstorm, .thunderstormWithRain, .thunderstormWithHail:
            conditionImage.image = #imageLiteral(resourceName: "thunder")
        case .none:
            conditionImage.image = #imageLiteral(resourceName: "none")
        }
    }
    
    private func setTempLabel(with temperature: Int) {
        if temperature < 100 {
            tempLabel.text = ("\(temperature)" + "??")
        } else {
            tempLabel.text = "--"
        }
    }
    
    private func configureCell() {
        let stackView = UIStackView(arrangedSubviews: [tempLabel, conditionImage])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        addSubview(cityLabel)
        let cityNameWidth: CGFloat = 120
        [
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20) ,
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            cityLabel.widthAnchor.constraint(equalToConstant: cityNameWidth)
        ].forEach { $0.isActive = true }
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ].forEach { $0.isActive = true }
    }
    
}
