//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    lazy var dayLabel = UIFactory.createLabel(textAlignment: .left)
    lazy var iconImage = UIFactory.createImageView()
    lazy var minMaxTempLabel = UIFactory.createLabel(textAlignment: .right)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configure(with: nil, date: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        [dayLabel, iconImage, minMaxTempLabel].forEach { contentView.addSubview($0) }
                
        dayLabel.left(contentView.leftAnchor, constant: 20)
            .centerY(contentView.centerYAnchor)
        dayLabel.setContentHugging(1000, axix: .horizontal)
        dayLabel.setContentCompression(1000, axix: .horizontal)
        
        iconImage.left(contentView.leftAnchor, constant: 80)
            .centerY(contentView.centerYAnchor)
            .width(40)
            .height(40)
        
        minMaxTempLabel.right(contentView.rightAnchor, constant: -20)
            .centerY(contentView.centerYAnchor)
        
        let separator = UIFactory.createSeparatorView()
        contentView.addSubview(separator)
        separator.left(contentView.leftAnchor, constant: 20)
            .right(contentView.rightAnchor, constant: -20)
            .bottom(contentView.bottomAnchor)
            .height(0.5)
        self.selectionStyle = .none
        
    }
    
    func configure(with viewModel: ForecastCellViewModelType?, date: Date?) {
        dayLabel.text = date?.stringValue(format: "EEE", timeZone: .current)
        iconImage.setImage(url: viewModel?.iconUrl)
        minMaxTempLabel.text = "H: \(viewModel?.maxTemperature ?? "--")    L: \(viewModel?.minTemperature ?? "--")"
    }
    
}
