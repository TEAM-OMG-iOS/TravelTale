//
//  DiscoveryRegionSettingView.swift
//  TravelTale
//
//  Created by 배지해 on 6/11/24.
//

import UIKit

final class DiscoveryRegionSettingView: BaseView {
    
    // MARK: - properties
    private let cityBackground = GrayBackgroundView()
    
    private let cityLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "시/도")
    }
    
    let cityButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
    }
    
    private let currentCityLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular),
                          text: "대구시")
    }
    
    private let districtBackground = GrayBackgroundView()
    
    private let districtLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "구/군")
    }
    
    let districtButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
    }
    
    private let currentDistrictLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular),
                          text: "달서구")
    }
    
    let submitButton = GreenButton()
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(cityBackground)
        cityBackground.addSubview(cityLabel)
        cityBackground.addSubview(cityButton)
        cityBackground.addSubview(currentCityLabel)
        self.addSubview(districtBackground)
        districtLabel.addSubview(districtLabel)
        districtLabel.addSubview(districtButton)
        districtLabel.addSubview(currentDistrictLabel)
    }
    
    override func configureConstraints() {
        cityBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(44)
        }
        
        cityLabel.snp.makeConstraints {
            $0.leading.equalTo(cityBackground.snp.leading).offset(16)
            $0.centerY.equalTo(cityBackground.snp.centerY)
        }
        
        cityButton.snp.makeConstraints {
            $0.trailing.equalTo(cityBackground.snp.trailing).offset(16)
            $0.top.equalTo(cityBackground.snp.top).offset(12)
            $0.bottom.equalTo(cityBackground.snp.bottom).offset(12)
            $0.height.equalTo(cityButton.snp.width)
        }
        
        currentCityLabel.snp.makeConstraints {
            $0.trailing.equalTo(cityButton.snp.leading).offset(4)
            $0.centerY.equalTo(cityBackground.snp.centerY)
        }
        
        districtBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(cityBackground.snp.bottom).offset(24)
        }
        
        districtLabel.snp.makeConstraints {
            $0.leading.equalTo(districtBackground.snp.leading).offset(16)
            $0.centerY.equalTo(districtBackground.snp.centerY)
        }
        
        districtButton.snp.makeConstraints {
            $0.trailing.equalTo(districtBackground.snp.trailing).offset(16)
            $0.top.equalTo(districtBackground.snp.top).offset(12)
            $0.bottom.equalTo(districtBackground.snp.bottom).offset(12)
            $0.height.equalTo(districtButton.snp.width)
        }
        
        currentDistrictLabel.snp.makeConstraints {
            $0.trailing.equalTo(districtButton.snp.leading).offset(4)
            $0.centerY.equalTo(districtBackground.snp.centerY)
        }
    }
}
