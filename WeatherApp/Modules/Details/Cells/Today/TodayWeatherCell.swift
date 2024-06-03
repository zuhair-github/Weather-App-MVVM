//
//  TodayWeatherCell.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    
    lazy var cityLabel = UIFactory.createLabel(textAlignment: .center)
    lazy var tempLabel = UIFactory.createLabel(fontSize: .custom(value: 50), textAlignment: .center)
    lazy var summaryLabel = UIFactory.createLabel(textAlignment: .center)
    lazy var minMaxTempLabel = UIFactory.createLabel(textAlignment: .center)
    lazy var descriptionLabel = UIFactory.createLabel(textAlignment: .left)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupUI() {
            
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(containerView)
        
        [cityLabel, tempLabel, summaryLabel, minMaxTempLabel].forEach {
            containerView.addSubview($0)
            $0.left(containerView.leftAnchor)
                .right(containerView.rightAnchor)
        }
        
        cityLabel.top(containerView.topAnchor)
            .bottom(tempLabel.topAnchor, constant: -5)
        
        tempLabel.bottom(summaryLabel.topAnchor, constant: -5)
        summaryLabel.bottom(minMaxTempLabel.topAnchor, constant: -5)
        minMaxTempLabel.bottom(containerView.bottomAnchor, constant: -5)
        descriptionLabel.left(contentView.leftAnchor, constant: 20)
            .right(contentView.rightAnchor, constant: 20)
            .bottom(contentView.bottomAnchor, constant: -20)
        
        containerView.left(contentView.leftAnchor)
            .right(contentView.rightAnchor)
            .centerY(contentView.centerYAnchor, constant: -30)
        self.selectionStyle = .none
        
    }
    
    func configure(viewModel: TodayWeatherCellViewModelType) {
        cityLabel.text = viewModel.city
        tempLabel.text = viewModel.temperature
        summaryLabel.text = viewModel.summary
        minMaxTempLabel.text = "H: \(viewModel.maxTemperature ?? "")    L: \(viewModel.minTemperature ?? "")"
        descriptionLabel.text = viewModel.description
    }
    
}
