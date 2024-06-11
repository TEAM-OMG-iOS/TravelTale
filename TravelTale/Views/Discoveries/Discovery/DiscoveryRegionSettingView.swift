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
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "시/도")
    }
    
    private let districtBackground = GrayBackgroundView()
    
    private let districtLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "구/군")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(cityBackground)
        cityBackground.addSubview(cityLabel)
        self.addSubview(districtBackground)
        districtLabel.addSubview(districtLabel)
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
        
        districtBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(cityBackground.snp.bottom).offset(24)
        }
        
        districtLabel.snp.makeConstraints {
            $0.leading.equalTo(districtBackground.snp.leading).offset(16)
            $0.centerY.equalTo(districtBackground.snp.centerY)
        }
    }
}
