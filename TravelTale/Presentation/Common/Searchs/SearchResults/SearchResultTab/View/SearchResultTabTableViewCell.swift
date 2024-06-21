//
//  SearchResultTabTableViewCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

final class SearchResultTabTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: SearchResultTabTableViewCell.self)
    
    private let placeImageView = UIImageView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 14)
    }
    
    private let typeLabel = UILabel().then {
        $0.configureLabel(color: .gray95, font: .pretendard(size: 12, weight: .medium))
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    private let addressLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 12, weight: .regular), numberOfLines: 2)
    }
    
    let bookmarkButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.tintColor = .gray80
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(placeImageView)
        self.addSubview(typeLabel)
        self.addSubview(titleLabel)
        self.addSubview(addressLabel)
        self.addSubview(bookmarkButton)
    }
    
    override func configureConstraints() {
        placeImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(100)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView)
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(typeLabel)
            $0.trailing.equalTo(bookmarkButton.snp.leading).offset(-16)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(bookmarkButton.snp.leading)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(typeLabel)
            $0.trailing.equalToSuperview().offset(-24)
            $0.size.equalTo(24)
        }
    }
}
