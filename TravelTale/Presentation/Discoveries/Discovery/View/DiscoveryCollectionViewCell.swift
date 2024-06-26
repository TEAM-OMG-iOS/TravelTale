//
//  DiscoveryCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/8/24.
//

import UIKit
import Kingfisher

final class DiscoveryCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: DiscoveryCollectionViewCell.self)
    
    private let placeContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let placeImageView = UIImageView().then {
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFill
        $0.configureView(color: .gray20, clipsToBounds: true, cornerRadius: 15)
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .semibold), numberOfLines: 2)
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(color: .gray120, font: .pretendard(size: 10, weight: .regular), numberOfLines: 2)
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
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(130)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func bind(place: Place) {
        if let imageString = place.firstImage, let image = URL(string: imageString) {
            placeImageView.kf.setImage(with: image)
        } else {
            placeImageView.image = .discoveryPlaceThumnail
        }
        
        if let place = place.title {
            placeLabel.text = place
        }
        
        if let address = place.addr1 {
            placeAddressLabel.text = address
        }
    }
}
