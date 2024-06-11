//
//  DiscoveryCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/8/24.
//

import UIKit

final class DiscoveryCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = "DiscoveryCell"
    
    private let placeContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let placeImageView = UIImageView().then {
        $0.configureView(color: .gray20, clipsToBounds: true, cornerRadius: 15)
        $0.tintColor = .white
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .semibold), numberOfLines: 2)
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 10, weight: .regular), numberOfLines: 2)
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        placeImageView.image = nil
        placeLabel.text = nil
        placeAddressLabel.text = nil
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(placeContainerView)
        contentView.addSubview(placeImageView)
        contentView.addSubview(placeLabel)
        contentView.addSubview(placeAddressLabel)
    }
    
    override func configureConstraints() {
        placeContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeImageView.snp.makeConstraints {
            $0.top.equalTo(placeContainerView.snp.top)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
            $0.height.equalTo(130)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.equalTo(placeContainerView.snp.leading)
            $0.trailing.equalTo(placeContainerView.snp.trailing)
        }
    }
    
    func bind(placeImage: UIImage?, place: String, placeAddress: String) {
        if let image = placeImage {
            placeImageView.image = image
        }
        placeLabel.text = place
        placeAddressLabel.text = placeAddress
    }
}
