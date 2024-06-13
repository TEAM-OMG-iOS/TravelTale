//
//  TravelDetailPlanHeaderContentCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/12/24.
//

import UIKit

final class TravelDetailPlanHeaderContentCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: TravelDetailPlanHeaderContentCell.self)
    
    private let dayLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .green100, font: .oaGothic(size: 15, weight: .heavy))
    }
    
    private let underlineView = UIView().then {
        $0.configureView(color: .green100)
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        dayLabel.text = nil
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(dayLabel)
        self.contentView.addSubview(underlineView)
    }
    
    override func configureConstraints() {
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(dayLabel)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(3)
        }
    }
}
