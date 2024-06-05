//
//  LocationTableViewCell.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

class LocationTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    static let identifier = "LocationTableViewCell"
    
    let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Methods
    override func configureUI() {
        self.backgroundColor = .white
        
        locationLabel.font = UIFont(name: "Pretendard-Bold", size: 15)
    }
    
    override func configureHierarchy() { 
        self.addSubview(locationLabel)
    }
    
    override func configureConstraints() { 
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

