//
//  MainViewController.swift
//  Weather
//
//  Created by Alexander Pelevinov on 13.07.2021.
//

import UIKit

class MainViewController : UIViewController {
    
    private var timer: Timer?
    private var searchController: UISearchController!
    private lazy var searchResultsController: SearchResultsController = {
       let controller = SearchResultsController()
        controller.addCitydelegate = self
        return controller
    }()
    private var dataProvider: ForecastProvider!
    private let tableView = UITableView()
    private let rowHeight: CGFloat = 140
    private var weatherData = [CityInfo]() {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                tableView.reloadData()
                tableView.refreshControl?.endRefreshing()
            }}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = DataManager.configureDataManager()
        configureTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Forecast"
        setupSearchController()
        updateWeatherData()
        configRefreshControl()
    }
    
    private func updateWeatherData() {
        dataProvider.getForecast { [weak self] response in
            guard let self = self else { return }
            self.weatherData = response
        }}
    
    private func configRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(handleRefreshControl),
                                            for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        updateWeatherData()
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
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        controller.weatherData = weatherData[indexPath.row]
        controller.addCitydelegate = self
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableCell.reuseIdentifier,
                                                       for: indexPath) as? WeatherTableCell else { fatalError() }
        let weather = weatherData[indexPath.row]
        cell.set(weather)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            dataProvider.removeCity(weatherData[indexPath.row])
            weatherData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension MainViewController: AddCityDelegate {
    func didAddCity(city: CityInfo) {
        guard !weatherData.contains(city) else { return }
        weatherData.append(city)
        dataProvider.append(city)
        let newIndexPath = IndexPath(row: weatherData.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}

extension MainViewController {
    private func setupSearchController() {
            searchController = UISearchController(searchResultsController: searchResultsController)
            navigationItem.searchController = searchController
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.searchBar.placeholder = "Find a city"
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
        }
    
    func searchFor(_ searchText: String?) {
        timer?.invalidate()
      guard searchController.isActive else { return }
      guard let searchText = searchText else {
        searchResultsController.weatherData = nil
        return
      }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.7,
                                     repeats: false,
                                     block: { [weak self] (_) in
                                        guard let self = self else { return }
                                        self.dataProvider.getForecast(by: searchText) {[weak self] result in
                                            guard let self = self else { return }
                                            switch result {
                                            case .success(let weatherData):
                                                self.searchResultsController.weatherData = weatherData
                                            case .failure(let error):
                                                print(error.localizedDescription)
                                            }
                                        }
                                     })
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFor(searchText)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}
