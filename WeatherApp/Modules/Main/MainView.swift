//
//  MainView.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class MainView: UIViewController {
    
    //MARK: - Views
    lazy var tableView = UIFactory.createTableView()
    
    var viewModel: MainViewModelType!
    var coordinator: Coordinator!
    var showAddButton: Bool = true
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupUI()
        setupBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.loadData()
    }
    
    init(viewModel: MainViewModelType, coordinator: Coordinator) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MainView {
    func setupUI() {
        view.addSubview(tableView)
        tableView.top(view.safeAreaLayoutGuide.topAnchor)
            .left(view.safeAreaLayoutGuide.leftAnchor)
            .right(view.safeAreaLayoutGuide.rightAnchor)
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        
        if showAddButton {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapAddButton))
        }
    }
    
    func setupBindings() {
        viewModel.output.showError
            .bind { [weak self] in self?.showErrorAlert(message: $0) }.disposed(by: disposeBag)
        
        viewModel.output.cities.bind(to: tableView.rx.items(cellIdentifier: CityCell.identifier, cellType: CityCell.self)) { index, city, cell in
            cell.nameLabel.text = city.name
            if city.current {
                cell.favoriteButton.setImage(UIImage(systemName: "location"), for: .normal)
                cell.favoriteButton.isUserInteractionEnabled = false
                cell.favoriteButton.tintColor = nil
            } else {
                cell.favoriteButton.setImage(UIImage(systemName: city.favorite ? "heart.fill" : "heart"), for: .normal)
                cell.favoriteButton.tintColor = city.favorite ? .red : .gray
                cell.favoriteButton.tag = index
                cell.favoriteButton.isUserInteractionEnabled = true
                cell.favoriteButton.addTarget(self, action: #selector(MainView.didTapFavoriteButton(_:)), for: .touchUpInside)
            }
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.input.removeCity(at: indexPath.row)
            })
            .disposed(by: disposeBag)
//        UIImage(systemName: "location")
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    @objc func didTapAddButton() {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter city name"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let name = alert.textFields?.first?.text else { return }
            self.viewModel.input.validateAndAddCity(name: name)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapFavoriteButton(_ sender: UIButton) {
        viewModel.input.toggleFavorite(at: sender.tag)
    }
}

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return viewModel.output.shouldEdit(at: indexPath.row) ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel.output.city(at: indexPath.row) else { return }
        coordinator.showDetailsView(city: city.name)
    }
}
