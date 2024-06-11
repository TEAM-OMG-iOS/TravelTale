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
    
    private let districtBackground = GrayBackgroundView()
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(cityBackground)
        self.addSubview(districtBackground)
    }
    
    override func configureConstraints() {
        cityBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(44)
        }
        
        districtBackground.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(cityBackground.snp.bottom).offset(24)
        }
    }
}
