//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class DetailsView: UIViewController {
    
    // MARK: - Properties
    var viewModel: DetailsViewModelType!
    var coordinator: Coordinator!
    
    let disposeBag = DisposeBag()
    var todayWeather: TodayWeatherCellViewModelType = TodayWeatherCellViewModel(data: nil) { didSet { tableView.reloadSections([0], with: .automatic) } }
    var weatherForcost: [ForecastCellViewModelType] = [] { didSet { tableView.reloadSections([1], with: .automatic) } }
    
    //MARK: - Views
    lazy var tableView = UIFactory.createTableView()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupUI()
        viewModel.input.loadData()
        setupBindings()
    }
    
    init(viewModel: DetailsViewModelType, coordinator: Coordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Helping Methods
extension DetailsView {
    func setupUI() {
        view.addSubview(tableView)
        tableView.top(view.safeAreaLayoutGuide.topAnchor)
            .left(view.safeAreaLayoutGuide.leftAnchor)
            .right(view.safeAreaLayoutGuide.rightAnchor)
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
        tableView.register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.identifier)
        tableView.register(TodayWeatherCell.self, forCellReuseIdentifier: TodayWeatherCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func setupBindings() {
        viewModel.output.showError
            .bind { [weak self] in self?.showErrorAlert(message: $0) }.disposed(by: disposeBag)
        viewModel.output.forecastWeatherViewModel.withUnretained(self)
             .subscribe(onNext: { `self`, result in self.weatherForcost = result })
             .disposed(by: disposeBag)
        viewModel.output.todayWeatherViewModel.withUnretained(self)
            .subscribe(onNext: { `self`, result in self.todayWeather = result })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Helping Methods
extension DetailsView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.output.forecaseDays
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayWeatherCell.identifier, for: indexPath) as! TodayWeatherCell
            cell.configure(viewModel: todayWeather)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier, for: indexPath) as! ForecastCell
        cell.configure(with: weatherForcost.object(at: indexPath.row), date: Date().dateByAdding(days: indexPath.row + 1))
        return cell
    }
    
}
