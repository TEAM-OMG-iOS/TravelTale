//
//  PlaceDetailImageCollectionViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import UIKit

final class PlaceDetailImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    let identifier = String(describing: PlaceDetailImageCollectionViewCell.self)
    
    private let detailImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(detailImage)
    }
    
    override func configureConstraints() {
        detailImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(image: UIImage) {
        detailImage.image = image
    }
}
