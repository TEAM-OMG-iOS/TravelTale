//
//  DiscoveryView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class DiscoveryView: BaseView {
    
    // MARK: - properties
    private let realmManager = RealmManager.shared
    
    static let regionDefaultText = "지역을 설정해주세요"
    
    let regionLabelButton = UIButton().then {
        $0.configureButton(font: .pretendard(size: 18, weight: .bold), text: regionDefaultText)
    }
    
    let regionButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    }
    
    private let regionStackView = UIStackView().then {
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    lazy var regionBarItem = UIBarButtonItem(customView: regionStackView)
    
    let searchButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = .search.withRenderingMode(.alwaysOriginal)
    }
    
    private let separatorLine = UIView().then {
        $0.configureView(color: .gray5)
    }
    
    private let categoryStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    lazy var touristSpotButton = UIButton().then {
        $0.tag = 0
        $0.setImage(.touristSpot, for: .normal)
    }
    
    private let line1 = UIImageView(image: .line)
    
    lazy var restaurantButton = UIButton().then {
        $0.tag = 1
        $0.setImage(.restaurant, for: .normal)
    }
    
    private let line2 = UIImageView(image: .line)
    
    lazy var accommodationButton = UIButton().then {
        $0.tag = 2
        $0.setImage(.accommodation, for: .normal)
    }
    
    private let line3 = UIImageView(image: .line)
    
    lazy var entertainmentButton = UIButton().then {
        $0.tag = 3
        $0.setImage(.entertainment, for: .normal)
    }
    
    private let recentlyAddedLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "최근 등록된 플레이스")
    }
    
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 20, bottom: 20, right: 20)
        $0.backgroundColor = .white
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        regionStackView.addArrangedSubview(regionLabelButton)
        regionStackView.addArrangedSubview(regionButton)
        self.addSubview(separatorLine)
        self.addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(touristSpotButton)
        categoryStackView.addArrangedSubview(line1)
        categoryStackView.addArrangedSubview(restaurantButton)
        categoryStackView.addArrangedSubview(line2)
        categoryStackView.addArrangedSubview(accommodationButton)
        categoryStackView.addArrangedSubview(line3)
        categoryStackView.addArrangedSubview(entertainmentButton)
        self.addSubview(recentlyAddedLabel)
        self.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        separatorLine.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.height.equalTo(6)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(separatorLine.snp.bottom).offset(24)
            $0.height.equalTo(64)
        }
        
        recentlyAddedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(categoryStackView.snp.bottom).offset(32)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(recentlyAddedLabel.snp.bottom).offset(12)
            $0.height.equalTo(476)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setRegionLabel() {
        guard let region = realmManager.fetchRegion() else { return }
        
        let regionString = "\(region.sido) \(region.sigungu ?? "")"
        regionLabelButton.configureButton(font: .pretendard(size: 18, weight: .bold), text: regionString)
    }
}
