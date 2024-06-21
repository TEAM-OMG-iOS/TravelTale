//
//  TravelMemoryEditPhotoCollectionViewCell.swift
//  TravelTale
//
//  Created by 유림 on 6/13/24.
//

import UIKit

final class MemoryAddEditPhotoCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: MemoryAddEditPhotoCollectionViewCell.self)
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let primaryPhotoLabel = UILabel().then {
        $0.isHidden = true
        $0.configureView(color: .blueBlack100)
        $0.configureLabel(alignment: .center,
                          color: .white,
                          font: .pretendard(size: 12, weight: .medium),
                          text: "대표 사진")
    }
    
    // MARK: - methods
    override func configureUI() {
        contentView.configureView(clipsToBounds: true, cornerRadius: 10)
    }
    
    override func configureHierarchy() { 
        [imageView,
         primaryPhotoLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        primaryPhotoLabel.snp.makeConstraints {
            $0.height.equalTo(22)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func bind(image: UIImage) {
        imageView.image = image
    }
    
    func showPrimaryPhotoLabel(index: Int) {
        if index == 0 {
            primaryPhotoLabel.isHidden = false
        } else {
            primaryPhotoLabel.isHidden = true
        }
    }
}
