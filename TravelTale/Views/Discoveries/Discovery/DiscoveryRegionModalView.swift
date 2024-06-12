//
//  DiscoveryRegionModalView.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalView: BaseView {
    
    // MARK: - properties
    private let selectLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    let regionTableView = UITableView()
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(selectLabel)
        self.addSubview(regionTableView)
    }
    
    override func configureConstraints() {
        selectLabel.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(36)
        }
        
        regionTableView.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalTo(selectLabel.snp.bottom).offset(36)
            $0.bottom.equalToSuperview()
        }
    }
}
