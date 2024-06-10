//
//  DiscoveryView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class DiscoveryView: BaseView {
    
    // MARK: - properties
    let regionButton = UIButton()
    
    let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "search"), for: .normal)
    }
    
    private let categoryStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    
    let touristSpotButton = UIButton()
    let restaurantButton = UIButton()
    let accommodationButton = UIButton()
    let entertainmentButton = UIButton()
    
    private let recentlyAddedLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "최근 등록된 플레이스")
    }
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private let minimumLineSpacing: CGFloat = 20
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        guard let chevron = UIImage(systemName: "chevron.down"),
              let touristSpot = UIImage(named: "tourist_spot"),
              let restaurant = UIImage(named: "restaurant"),
              let accommodation = UIImage(named: "accommodation"),
              let entertainment = UIImage(named: "entertainment") else { return }
        
        regionButton.configuration = configureButton(titleString: "대구시 달서구",
                                                     titleFont: UIFont.pretendard(size: 18, weight: .bold),
                                                     image: chevron,
                                                     imagePlacement: .trailing,
                                                     imagePadding: 8,
                                                     imgaeSize: 12)
        touristSpotButton.configuration = configureButton(titleString: "관광지", image: touristSpot)
        restaurantButton.configuration = configureButton(titleString: "음식점", image: restaurant)
        accommodationButton.configuration = configureButton(titleString: "숙박", image: accommodation)
        entertainmentButton.configuration = configureButton(titleString: "놀거리", image: entertainment)
    }
    
    override func configureHierarchy() {
        self.addSubview(regionButton)
        self.addSubview(searchButton)
        self.addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(touristSpotButton)
        categoryStackView.addArrangedSubview(restaurantButton)
        categoryStackView.addArrangedSubview(accommodationButton)
        categoryStackView.addArrangedSubview(entertainmentButton)
        self.addSubview(recentlyAddedLabel)
        self.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        regionButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            $0.leading.equalToSuperview().inset(12)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(regionButton.snp.centerY)
            $0.height.equalToSuperview().multipliedBy(0.04225352113)
            $0.height.equalTo(searchButton.snp.width)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(regionButton.snp.bottom).offset(32)
            $0.height.equalToSuperview().multipliedBy(0.06572769953)
        }
        
        recentlyAddedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(categoryStackView.snp.bottom).offset(48)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(recentlyAddedLabel.snp.bottom)
            $0.height.equalTo(476)
        }
    }
    
    private func configureButton(titleString: String,
                                 titleFont: UIFont = UIFont.pretendard(size: 15, weight: .regular),
                                 image: UIImage,
                                 imagePlacement: NSDirectionalRectEdge = .top,
                                 imagePadding: CGFloat = 4,
                                 imgaeSize: CGFloat = 35) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        
        var title = AttributedString.init(titleString)
        title.font = titleFont
        
        configuration.attributedTitle = title
        configuration.baseForegroundColor = UIColor.black
        configuration.image = image
        configuration.imagePlacement = imagePlacement
        configuration.imagePadding = imagePadding
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: imgaeSize)
        
        return configuration
    }
}
