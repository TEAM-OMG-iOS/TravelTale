//
//  PlaceDetailCollectionViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import UIKit
import Kingfisher

final class PlaceDetailCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: PlaceDetailCollectionViewCell.self)
    
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
    
    func bind(image: String) {
        if let image = URL(string: image) {
            detailImage.kf.setImage(with: image)
        }
    }
}
