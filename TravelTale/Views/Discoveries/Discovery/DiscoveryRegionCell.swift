//
//  DiscoveryRegionCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = "DiscoveryRegionCell"
    
    let regionContainerView = UIView().then {
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 20)
    }
    
    let checkImageView = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
    }
    
    private let regionLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 15, weight: .bold))
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        regionContainerView.backgroundColor = .white
        regionLabel.text = nil
        checkImageView.isHidden = true
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(regionContainerView)
        contentView.addSubview(checkImageView)
        contentView.addSubview(regionLabel)
    }
    
    override func configureConstraints() {
        regionContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        checkImageView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(16)
            $0.width.equalTo(checkImageView.snp.height)
        }
        
        regionLabel.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.trailing.equalTo(checkImageView.snp.leading).inset(16)
        }
    }
    
    func bind(regionString: String) {
        regionLabel.text = regionString
    }
}
