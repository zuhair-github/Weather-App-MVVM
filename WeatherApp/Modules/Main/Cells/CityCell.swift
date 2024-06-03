//
//  CityCell.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

class CityCell: UITableViewCell {
    
    lazy var nameLabel = UIFactory.createLabel(textAlignment: .left)
    
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
    
    func setupUI() {
        contentView.addSubview(nameLabel)
                
        nameLabel.left(contentView.leftAnchor, constant: 20)
            .centerY(contentView.centerYAnchor)
            .right(contentView.rightAnchor, constant: 20)
        
        
        let separator = UIFactory.createSeparatorView()
        contentView.addSubview(separator)
        separator.left(contentView.leftAnchor, constant: 20)
            .right(contentView.rightAnchor, constant: -20)
            .bottom(contentView.bottomAnchor)
            .height(0.5)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        
    }
    
}
