//
//  DiscoveryView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class DiscoveryView: BaseView {
    
    // MARK: - properties
    lazy var regionButton = UIButton().then {
        guard let chevron = UIImage(systemName: "chevron.down") else { return }
        
        $0.configuration = configureButton(titleString: "대구시 달서구",
                                           titleFont: .pretendard(size: 18, weight: .bold),
                                           image: chevron,
                                           imagePlacement: .trailing,
                                           imagePadding: 8,
                                           imageSize: 12)
    }
    
    let searchButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = .search.withRenderingMode(.alwaysOriginal)
    }
    
    private let categoryStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    
    lazy var touristSpotButton = UIButton().then {
        $0.configuration = configureButton(titleString: "관광지", image: .touristSpot)
    }
    
    lazy var restaurantButton = UIButton().then {
        $0.configuration = configureButton(titleString: "음식점", image: .restaurant)
    }
    
    lazy var accommodationButton = UIButton().then {
        $0.configuration = configureButton(titleString: "숙박", image: .accommodation)
    }
    
    lazy var entertainmentButton = UIButton().then {
        $0.configuration = configureButton(titleString: "놀거리", image: .entertainment)
    }
    
    private let recentlyAddedLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "최근 등록된 플레이스")
    }
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(touristSpotButton)
        categoryStackView.addArrangedSubview(restaurantButton)
        categoryStackView.addArrangedSubview(accommodationButton)
        categoryStackView.addArrangedSubview(entertainmentButton)
        self.addSubview(recentlyAddedLabel)
        self.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        categoryStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(32)
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
                                 titleFont: UIFont = .pretendard(size: 15, weight: .regular),
                                 image: UIImage,
                                 imagePlacement: NSDirectionalRectEdge = .top,
                                 imagePadding: CGFloat = 4,
                                 imageSize: CGFloat = 35) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        
        var title = AttributedString.init(titleString)
        title.font = titleFont
        
        configuration.attributedTitle = title
        configuration.baseForegroundColor = .black
        configuration.image = image
        configuration.imagePlacement = imagePlacement
        configuration.imagePadding = imagePadding
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: imageSize)
        
        return configuration
    }
}
