//
//  DetailViewController.swift
//  Weather
//
//  Created by Alexander Pelevinov on 14.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var addCitydelegate: AddCityDelegate?
    private let tableView = UITableView()
    var weatherData: CityInfo? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }}}
    let titles = DetailTableParameters.titles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .white
        configureTableView()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(DetailScreenCell.self,
                           forCellReuseIdentifier: DetailScreenCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let weatherData = weatherData else { return nil }
        let header = DetailScreenHeader()
        header.set(with: weatherData)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        DetailTableParameters.headerHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DetailTableParameters.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailScreenCell.reuseIdentifier,
                                                       for: indexPath) as? DetailScreenCell else { fatalError() }
        let title = titles[indexPath.row]
        cell.set(title.rawValue)
        guard let weatherData = weatherData else { return cell }
        switch title {
        case .feelsLike:
            cell.set(parameter: ("\(weatherData.weather.feelsLike)" + "??"))
        case .humidity:
            cell.set(parameter: ("\(weatherData.weather.humidity) " + "%"))
        case .pressure:
            cell.set(parameter: ("\(weatherData.weather.pressure) " + "mm Hg"))
        case .wind:
            cell.set(parameter: ("\(weatherData.weather.wind) " + "m/s"))
        }
        return cell
    }
    
}
