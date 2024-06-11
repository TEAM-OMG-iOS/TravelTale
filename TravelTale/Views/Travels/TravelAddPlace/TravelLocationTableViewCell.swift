//
//  TravelLocationTableViewCell.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelLocationTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "LocationTableViewCell"
    
    let locationLabel = UILabel().then {
        $0.configureLabel(alignment: .left, 
                          color: .blueBlack100,
                          font: .pretendard(size: 15, weight: .bold))
    }
    
    let locationButton = UIButton()
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        locationLabel.text = ""
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func configureHierarchy() {
        [locationLabel, 
         locationButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

