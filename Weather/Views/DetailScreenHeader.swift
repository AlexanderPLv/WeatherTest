//
//  DetailScreenView.swift
//  Weather
//
//  Created by Alexander Pelevinov on 16.07.2021.
//

import UIKit

final class DetailScreenHeader: UIView, ReusableView {
    
    private let conditionImage = UIImageView()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.contentMode = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.contentMode = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with cityInfo: CityInfo?) {
        guard let cityInfo = cityInfo else { return }
        cityNameLabel.text = cityInfo.geoInfo.cityName
        tempLabel.text = ("\(cityInfo.weather.temp)" + "°")
        setImage(by: cityInfo.weather.condition)
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
    
    func configureUI() {
        let  topViewStackView = UIStackView(arrangedSubviews: [
                                                conditionImage,
                                                cityNameLabel,
                                                tempLabel, ])
        topViewStackView.translatesAutoresizingMaskIntoConstraints = false
        topViewStackView.axis = .vertical
        topViewStackView.alignment = .center
        addSubview(topViewStackView)
        [
            topViewStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topViewStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            topViewStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ].forEach{ $0.isActive = true }
    }
    
}
