//
//  CategoryTabTableViewCell.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit
import Kingfisher

final class CategoryTabTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: CategoryTabTableViewCell.self)
    
    private let containerView = UIView().then {
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 15)
        $0.layer.borderColor = UIColor.gray20.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let placeImageView = UIImageView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 15)
        $0.image = .categoryPlaceThumnail
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .medium), numberOfLines: 0)
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(color: .gray120, font: .pretendard(size: 10, weight: .regular), numberOfLines: 0)
    }
    
    private let bookmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.tintColor = .green100
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(placeImageView)
        containerView.addSubview(placeLabel)
        containerView.addSubview(placeAddressLabel)
        containerView.addSubview(bookmarkButton)
    }
    
    override func configureConstraints() {
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.verticalEdges.equalToSuperview().inset(8)
        }
        
        placeImageView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview().inset(16)
            $0.height.equalTo(160)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(bookmarkButton.snp.leading).offset(-8)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(8)
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(placeLabel)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(12)
            $0.trailing.equalTo(placeImageView)
            $0.size.equalTo(24)
        }
    }
    
    func bind(place: Place) {
        if let firstImage = place.firstImage, let imageURL = URL(string: firstImage) {
            placeImageView.kf.setImage(with: imageURL, placeholder: UIImage.categoryPlaceThumnail)
        }
        
        if let title = place.title {
            placeLabel.text = place.title
        }
        
        let placeString = [place.addr1, place.addr2].compactMap { $0 }.joined(separator: " ")
        placeAddressLabel.text = placeString.isEmpty ? "주소 없음" : placeString
    }
}
