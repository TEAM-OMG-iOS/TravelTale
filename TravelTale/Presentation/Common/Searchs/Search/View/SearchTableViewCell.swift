//
//  SearchTableViewCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

final class SearchTableViewCell: BaseTableViewCell {

    // MARK: - properties
    static let identifier = String(describing: SearchTableViewCell.self)
    
    private let clockImageView = UIImageView().then {
        $0.image = .searchClock
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(color: .black.withAlphaComponent(0.5), font: .pretendard(size: 16, weight: .semibold))
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black.withAlphaComponent(0.5)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(clockImageView)
        self.addSubview(titleLabel)
        self.addSubview(deleteButton)
    }
    
    override func configureConstraints() {
        clockImageView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(16)
            $0.size.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(clockImageView)
            $0.leading.equalTo(clockImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalTo(clockImageView)
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(14)
        }
    }
}
