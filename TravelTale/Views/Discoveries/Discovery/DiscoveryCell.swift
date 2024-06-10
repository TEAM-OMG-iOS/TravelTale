//
//  DiscoveryCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/8/24.
//

import UIKit

final class DiscoveryCell: BaseCollectionViewCell {
    
    // MARK: - properties
    private let placeContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let placeImageView = UIImageView().then {
        $0.image = UIImage(systemName: "photo")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .semibold), numberOfLines: 3)
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 10, weight: .regular), numberOfLines: 2)
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.placeContainerView.addSubview(placeImageView)
        self.placeContainerView.addSubview(placeLabel)
        self.placeContainerView.addSubview(placeAddressLabel)
    }
    
    override func configureConstraints() {
        placeContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeImageView.snp.makeConstraints {
            $0.top.equalTo(placeContainerView.snp.top)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
            $0.height.equalTo(placeImageView.snp.width).multipliedBy(0.78)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
            $0.bottom.equalTo(placeContainerView.snp.bottom)
        }
    }
}
