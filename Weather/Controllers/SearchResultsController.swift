//
//  SearchResultsController.swift
//  Weather
//
//  Created by Alexander Pelevinov on 18.07.2021.
//

import UIKit

class SearchResultsController: UIViewController {
    
    var addCitydelegate: AddCityDelegate?
    private let tableView = UITableView()
    private let buttonView = ButtonContainerView()
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
        configureUI()
        setupButtonAction()
    }
    
    private func setupButtonAction() {
        buttonView.buttonAction = { [weak self] in
                    guard let self = self,
                          let weatherData = self.weatherData else { return }
                    self.dismiss(animated: true) {
                        self.addCitydelegate?.didAddCity(city: weatherData)
                    }}
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        view.addSubview(buttonView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        [
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
        ].forEach{ $0.isActive = true }
        [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ].forEach{ $0.isActive = true }
        
    }
    
}

extension SearchResultsController: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView() {
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
            cell.set(parameter: ("\(weatherData.weather.feelsLike)" + "°"))
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
