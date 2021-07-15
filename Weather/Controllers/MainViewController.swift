//
//  MainViewController.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import UIKit

class MainViewController : UIViewController {
    
    let tableView = UITableView()
    let rowHeight: CGFloat = 150
    var weatherData = [CityInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let dataProvider: WeatherDataProvider!
    
    init() {
        dataProvider = DataManager.configureDataManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        dataProvider.getWeatherData { [weak self] response in
            guard let self = self else { return }
            self.weatherData = response
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.register(WeatherTableCell.self,
                           forCellReuseIdentifier: WeatherTableCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableCell.reuseIdentifier,
                                                       for: indexPath) as? WeatherTableCell else { fatalError() }
        let weather = weatherData[indexPath.row]
        cell.set(weather)
        return cell
    }
    
    
}
