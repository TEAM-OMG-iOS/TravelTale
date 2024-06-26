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
    private let realmManager = RealmManager.shared
    
    static let identifier = String(describing: CategoryTabTableViewCell.self)
    
    private let containerView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray20.cgColor
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 15)
    }
    
    private let placeImageView = UIImageView().then {
        $0.image = .categoryPlaceThumnail
        $0.contentMode = .scaleAspectFill
        $0.configureView(clipsToBounds: true, cornerRadius: 15)
    }
    
    private let placeLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .medium), numberOfLines: 0)
    }
    
    private let placeAddressLabel = UILabel().then {
        $0.configureLabel(color: .gray120, font: .pretendard(size: 10, weight: .regular), numberOfLines: 0)
    }
    
    private let bookmarkButton = UIButton().then {
        $0.tintColor = .green100
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
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
            placeImageView.kf.setImage(with: imageURL)
        }else {
            placeImageView.image = .categoryPlaceThumnail
        }
        
        if let title = place.title {
            placeLabel.text = place.title
        }
        
        placeAddressLabel.text = [place.addr1, place.addr2].compactMap({ $0 }).joined(separator: " ")
        
        guard let id = place.contentId else { return }
        
        if realmManager.fetchBookmarks(contentTypeId: .total).filter({ $0.contentId == id }).count > 0 {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    func bind(bookMark: Bookmark) {
        if let imageData = bookMark.image, let image = UIImage(data: imageData) {
            placeImageView.image = image
        }else {
            placeImageView.image = .categoryPlaceThumnail
        }
        
        if let title = bookMark.title {
            placeLabel.text = title
        }
        
        if let placeString = bookMark.address {
            placeAddressLabel.text = placeString
        }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }
}
