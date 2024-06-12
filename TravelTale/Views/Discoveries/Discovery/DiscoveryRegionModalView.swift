//
//  DiscoveryRegionModalView.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalView: BaseView {
    
    // MARK: - properties
    var selectLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(selectLabel)
    }
    
    override func configureConstraints() {
        selectLabel.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(36)
        }
    }
}
