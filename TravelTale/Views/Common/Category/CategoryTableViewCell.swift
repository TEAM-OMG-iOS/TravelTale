//
//  CategoryTableViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

final class CategoryTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    private let containerView = UIView().then {
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 15)
        $0.layer.borderColor = UIColor.gray20.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let placeImage = UIImageView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 15)
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .medium))
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 10, weight: .regular))
    }
    
    private let bookmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.tintColor = .green100
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(containerView)
        addSubview(placeImage)
        addSubview(placeLabel)
        addSubview(placeAddressLabel)
        addSubview(bookmarkButton)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
        
        placeImage.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview().inset(16)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImage.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(placeLabel)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(placeLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(placeImage)
            $0.size.equalTo(24)
        }
    }
}
