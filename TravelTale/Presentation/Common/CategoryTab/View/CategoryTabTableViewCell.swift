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
    
    private let categoryImage = UIImageView().then {
        $0.tintColor = .gray80
    }
    
    private let categoryName = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 12, weight: .semibold))
    }
    
    private let placeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
        containerView.addSubview(categoryImage)
        containerView.addSubview(categoryName)
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
            $0.horizontalEdges.top.equalToSuperview()
            $0.height.equalTo(180)
        }
        
        categoryImage.snp.makeConstraints {
            $0.top.equalTo(placeImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(12)
        }
        
        categoryName.snp.makeConstraints {
            $0.leading.equalTo(categoryImage.snp.trailing).offset(4)
            $0.centerY.equalTo(categoryImage)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.centerY.equalTo(categoryImage)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalTo(categoryImage.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        placeAddressLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview().inset(16)
        }
    }
    
    func bind(place: Place) {
        if let firstImage = place.firstImage, let imageURL = URL(string: firstImage) {
            placeImageView.kf.setImage(with: imageURL)
        } else {
            placeImageView.image = .categoryPlaceThumnail
        }
        
        if let category = place.contentTypeId {
            let categoryConfig: (image: String, text: String) = {
                switch category {
                case "12":
                    return ("building.columns", "관광지")
                case "39":
                    return ("fork.knife", "음식점")
                case "32":
                    return ("bed.double.fill", "숙박")
                case "15":
                    return ("balloon.2.fill", "놀거리")
                default:
                    return ("star.fill", "카테고리 없음")
                }
            }()
            
            categoryImage.image = UIImage(systemName: categoryConfig.image)
            categoryName.text = categoryConfig.text
        }
        
        if let title = place.title {
            placeLabel.text = title
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
        } else {
            placeImageView.image = .categoryPlaceThumnail
        }
        
        if let category = bookMark.contentTypeId {
            let categoryConfig: (image: String, text: String) = {
                switch category {
                case "12":
                    return ("building.columns", "관광지")
                case "39":
                    return ("fork.knife", "음식점")
                case "32":
                    return ("tent.fill", "숙박")
                case "15":
                    return ("balloon.2.fill", "놀거리")
                default:
                    return ("star.fill", "카테고리 없음")
                }
            }()
            
            categoryImage.image = UIImage(systemName: categoryConfig.image)
            categoryName.text = categoryConfig.text
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
