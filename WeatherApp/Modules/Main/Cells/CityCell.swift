//
//  CityCell.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import UIKit

class CityCell: UITableViewCell {
    
    lazy var nameLabel = UIFactory.createLabel(textAlignment: .left)
    lazy var favoriteButton = UIFactory.createButton()
    
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
        contentView.addSubview(favoriteButton)
                
        nameLabel.left(contentView.leftAnchor, constant: 20)
            .centerY(contentView.centerYAnchor)
        
        favoriteButton.left(contentView.rightAnchor, constant: 10)
            .centerY(contentView.centerYAnchor)
            .height(24)
            .width(24)
            .right(contentView.rightAnchor, constant: -20)
        
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .red
        
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
