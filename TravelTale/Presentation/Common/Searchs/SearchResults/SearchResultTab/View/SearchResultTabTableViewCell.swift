//
//  SearchResultTabTableViewCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit
import Kingfisher

final class SearchResultTabTableViewCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: SearchResultTabTableViewCell.self)
    
    private let placeImageView = UIImageView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 14)
    }
    
    private let typeLabel = UILabel().then {
        $0.configureLabel(color: .gray95, font: .pretendard(size: 12, weight: .medium))
    }
    
    private let titleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    private let addressLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 12, weight: .regular), numberOfLines: 2)
    }
    
    let bookmarkButton = UIButton().then {
        $0.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.tintColor = .gray80
    }
    
    // MARK: - life cycles
    override func prepareForReuse() {
        placeImageView.image = .placeProfile
        typeLabel.text = nil
        titleLabel.text = nil
        addressLabel.text = nil
        bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .gray80
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(placeImageView)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(bookmarkButton)
    }
    
    override func configureConstraints() {
        placeImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(100)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(placeImageView)
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(typeLabel)
            $0.trailing.equalTo(bookmarkButton.snp.leading).offset(-16)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(bookmarkButton.snp.leading)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(typeLabel)
            $0.trailing.equalToSuperview().offset(-24)
            $0.size.equalTo(24)
        }
    }
    
    func bind(place: PlaceSearch, isBookmarked: Bool) {
        if let imageURL = place.firstImage, !imageURL.isEmpty {
            placeImageView.kf.setImage(with: URL(string: imageURL))
        } else {
            placeImageView.image = .placeProfile
        }
        
        switch place.contentTypeId {
        case "12":
            typeLabel.text = "관광지"
        case "39":
            typeLabel.text = "음식점"
        case "32":
            typeLabel.text = "숙박"
        case "15":
            typeLabel.text = "놀거리"
        default:
            typeLabel.text = "카테고리 없음"
        }
        
        titleLabel.text = place.title
        
        if let addr1 = place.addr1 {
            addressLabel.text = addr1
            
            if let addr2 = place.addr2 {
                addressLabel.text! += " " + addr2
            }
        }
        
        if isBookmarked {
            bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkButton.tintColor = .green100
        }
    }
}
