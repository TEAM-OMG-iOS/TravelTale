//
//  PlaceDetailView.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import MapKit
import UIKit

final class PlaceDetailView: BaseView {
    
    // MARK: - properties
    let collectionViewHeight: CGFloat = 300
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .white
    }
    
    lazy var imageCollectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewLayout()).then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isPagingEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: UIScreen.main.bounds.size.width, height: collectionViewHeight)
        
        $0.collectionViewLayout = layout
    }
    
    let pageController = UIPageControl().then {
        $0.currentPageIndicatorTintColor = .green100
        $0.backgroundStyle = .automatic
    }
    
    private let placeName = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "설빙 석촌 호수점")
    }
    
    let bookMarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.tintColor = .green100
    }
    
    private let categoryImage = UIImageView().then {
        $0.image = UIImage(systemName: "fork.knife")
        $0.tintColor = .gray80
    }
    
    private let categoryName = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 12, weight: .semibold), text: "음식점")
    }
    
    private let line = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    private let phoneNumberImage = UIImageView().then {
        $0.image = UIImage(systemName: "phone")
        $0.tintColor = .black
    }
    
    private let phoneNumberTextView = UITextView().then {
        $0.text = "+82 010-5145-7665"
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.dataDetectorTypes = .phoneNumber
        $0.isEditable = false
        $0.textColor = .blue
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.isEditable = false
    }
    
    private let websiteImage = UIImageView().then {
        $0.image = UIImage(systemName: "globe")
        $0.tintColor = .black
    }
    
    private let websiteTextView = UITextView().then {
        $0.text = "www.naver.com"
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.dataDetectorTypes = .link
        $0.isEditable = false
        $0.textColor = .blue
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.isEditable = false
    }
    
    private let descriptionImage = UIImageView().then {
        $0.image = UIImage(systemName: "book.pages")
        $0.tintColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 14, weight: .medium),
                          text: "안녕하세요 여기는 설빙 석촌호수 동호점입니다. 안녕하세요 여기는 설빙 석촌호수 동호점입니다. 안녕하세요 여기는 설빙 석촌호수 동호점입니다. 안녕하세요 여기는 설빙 석촌호수 동호점입니다.",
                          numberOfLines: 0)
    }

    private let mapImage = UIImageView().then {
        $0.image = UIImage(systemName: "map")
        $0.tintColor = .black
    }
    
    private let mapLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 14, weight: .medium),
                          text: "서울 송파구 석촌 호수로 278",
                          numberOfLines: 0)
    }
    
    let copyAddressButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.on.square.intersection.dashed"),
                    for: .normal)
        $0.tintColor = .gray70
    }
    
    private let mapView = MKMapView()
    
    let addButton = UIButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 20, weight: .bold),
                           text: "일정에 추가하기")
        $0.configureView(color: .green100, clipsToBounds: true, cornerRadius: 20)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(pageController)
        contentView.addSubview(placeName)
        contentView.addSubview(bookMarkButton)
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        contentView.addSubview(line)
        contentView.addSubview(phoneNumberImage)
        contentView.addSubview(phoneNumberTextView)
        contentView.addSubview(websiteImage)
        contentView.addSubview(websiteTextView)
        contentView.addSubview(descriptionImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(mapImage)
        contentView.addSubview(mapLabel)
        contentView.addSubview(copyAddressButton)
        contentView.addSubview(mapView)
        contentView.addSubview(backButton)
        addSubview(addButton)
    }
    
    override func configureConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(addButton.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.size.equalTo(24)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(collectionViewHeight)
        }
        
        pageController.snp.makeConstraints {
            $0.bottom.equalTo(imageCollectionView).offset(-12)
            $0.centerX.equalToSuperview()
        }
        
        placeName.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(12)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(placeName)
            $0.size.equalTo(18)
        }
        
        categoryImage.snp.makeConstraints {
            $0.top.equalTo(placeName.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(18)
        }
        
        categoryName.snp.makeConstraints {
            $0.centerY.equalTo(categoryImage)
            $0.leading.equalTo(categoryImage.snp.trailing).offset(4)
        }
        
        line.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(2)
            $0.top.equalTo(categoryName.snp.bottom).offset(12)
        }
        
        phoneNumberImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalTo(phoneNumberTextView)
            $0.size.equalTo(18)
        }
        
        phoneNumberTextView.snp.makeConstraints {
            $0.leading.equalTo(phoneNumberImage.snp.trailing).offset(12)
            $0.top.equalTo(line.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        websiteImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalTo(websiteTextView)
            $0.size.equalTo(18)
        }
        
        websiteTextView.snp.makeConstraints {
            $0.leading.equalTo(websiteImage.snp.trailing).offset(12)
            $0.top.equalTo(phoneNumberTextView.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        descriptionImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(websiteTextView.snp.bottom).offset(16)
            $0.size.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(websiteImage.snp.trailing).offset(16)
            $0.top.equalTo(websiteTextView.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        mapImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.size.equalTo(18)
        }
        
        mapLabel.snp.makeConstraints {
            $0.leading.equalTo(mapImage.snp.trailing).offset(16)
            $0.top.equalTo(mapImage)
            $0.trailing.equalTo(copyAddressButton.snp.leading).offset(-12)
        }
        
        copyAddressButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(mapLabel)
            $0.size.equalTo(16)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(copyAddressButton.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview().inset(24)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo( safeAreaLayoutGuide )
        }
    }
}
