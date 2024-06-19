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
    let collectionViewHeight: CGFloat = 350
    let buttonHeight: CGFloat = 48
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = false
        $0.isDirectionalLockEnabled = true
    }
    
    private let contentView = UIView()
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .gray90
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
    
    private let placeName = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold))
    }
    
    private let categoryImage = UIImageView().then {
        $0.tintColor = .gray80
    }
    
    private let categoryName = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 12, weight: .semibold))
    }
    
    private let line = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    private let phoneNumberImage = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "phone")
    }
    
    private let phoneNumberTextView = UITextView().then {
        $0.textColor = .blue
        $0.isEditable = false
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.dataDetectorTypes = .phoneNumber
        $0.font = .pretendard(size: 14, weight: .medium)
    }
    
    private let phoneNumberStackView = UIStackView().then {
        $0.spacing = 12
        $0.isHidden = true
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let websiteImage = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "globe")
    }
    
    private let websiteTextView = UITextView().then {
        $0.textColor = .blue
        $0.isEditable = false
        $0.textAlignment = .left
        $0.isScrollEnabled = false
        $0.dataDetectorTypes = .link
        $0.font = .pretendard(size: 14, weight: .medium)
    }
    
    private let websiteStackView = UIStackView().then {
        $0.spacing = 12
        $0.isHidden = true
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let descriptionImage = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "book.pages")
    }
    
    private let descriptionLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 14, weight: .medium),
                          numberOfLines: 0)
    }
    
    private let descriptionStackView = UIStackView().then {
        $0.spacing = 16
        $0.isHidden = true
        $0.alignment = .top
        $0.axis = .horizontal
        $0.distribution = .fill
    }

    private let mapImage = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "map")
    }
    
    private let mapLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 14, weight: .medium),
                          numberOfLines: 0)
    }
    
    let copyAddressButton = UIButton().then {
        $0.tintColor = .gray70
        $0.setImage(UIImage(systemName: "square.on.square.intersection.dashed"),
                    for: .normal)
    }
    
    private let mapStackView = UIStackView().then {
        $0.spacing = 16
        $0.isHidden = true
        $0.axis = .horizontal
        $0.alignment = .top
        $0.distribution = .fill
    }
    
    let mapView = MKMapView().then {
        $0.configureView(clipsToBounds: true, cornerRadius: 15)
        $0.layer.borderColor = UIColor.gray20.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let detailStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    let buttonBackground = UIView().then {
        $0.configureView(color: .white)
        
        let topBorder = CALayer()
        topBorder.backgroundColor = UIColor.gray20.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1)
        $0.layer.addSublayer(topBorder)
    }
    
    let bookMarkButton = UIButton().then {
        $0.tintColor = .gray80
        $0.setBackgroundImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    let buttonLine = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    let addButton = UIButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "일정에 추가하기")
        $0.configureView(color: .green100, clipsToBounds: true, cornerRadius: 15)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(placeName)
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        contentView.addSubview(line)
        phoneNumberStackView.addArrangedSubview(phoneNumberImage)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextView)
        websiteStackView.addArrangedSubview(websiteImage)
        websiteStackView.addArrangedSubview(websiteTextView)
        descriptionStackView.addArrangedSubview(descriptionImage)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        mapStackView.addArrangedSubview(mapImage)
        mapStackView.addArrangedSubview(mapLabel)
        mapStackView.addArrangedSubview(copyAddressButton)
        contentView.addSubview(mapView)
        detailStackView.addArrangedSubview(phoneNumberStackView)
        detailStackView.addArrangedSubview(websiteStackView)
        detailStackView.addArrangedSubview(descriptionStackView)
        detailStackView.addArrangedSubview(mapStackView)
        contentView.addSubview(detailStackView)
        contentView.addSubview(backButton)
        addSubview(buttonBackground)
        buttonBackground.addSubview(bookMarkButton)
        buttonBackground.addSubview(buttonLine)
        buttonBackground.addSubview(addButton)
    }
    
    override func configureConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalTo(buttonBackground.snp.top)
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
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(collectionViewHeight)
        }
        
        placeName.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(16)
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
            $0.top.equalTo(categoryName.snp.bottom).offset(16)
        }
        
        phoneNumberImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        websiteImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        descriptionImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        mapImage.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        copyAddressButton.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        detailStackView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(mapStackView.snp.bottom).offset(12)
            $0.horizontalEdges.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(220)
        }
        
        buttonBackground.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(72)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.centerY.equalTo(buttonBackground)
            $0.width.equalTo(23)
            $0.height.equalTo(26)
        }
        
        buttonLine.snp.makeConstraints {
            $0.height.equalTo(buttonHeight)
            $0.leading.equalTo(bookMarkButton.snp.trailing).offset(24)
            $0.width.equalTo(1)
            $0.centerY.equalTo(buttonBackground)
        }
        
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(buttonBackground)
            $0.height.equalTo(buttonHeight)
            $0.leading.equalTo(buttonLine.snp.trailing).offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    func bind(placeName: String,
              placeCategory: String,
              placePhoneNumber: String?,
              placeWebSite: String?,
              placeDescription: String?,
              placeAddress: String?,
              isBookMarked: Bool) {
        self.placeName.text = placeName
        configureCategory(category: placeCategory)
        
        configureIfPresent(placePhoneNumber, using: configurePhoneNumber)
        configureIfPresent(placeWebSite, using: configureWebsite)
        configureIfPresent(placeDescription, using: configureDescription)
        configureIfPresent(placeAddress, using: configureMap)
        
        configureBookMarkButton(isBookMarked: isBookMarked)
    }
    
    private func configureCategory(category: String) {
        let categoryConfig: (image: String, text: String) = {
            switch category {
            case "관광지":
                return ("building.columns", category)
            case "음식점":
                return ("fork.knife", category)
            case "숙박":
                return ("tent.fill", category)
            case "놀거리":
                return ("balloon.2.fill", category)
            default:
                return ("star.fill", "카테고리 없음")
            }
        }()
        categoryImage.image = UIImage(systemName: categoryConfig.image)
        categoryName.text = categoryConfig.text
    }
    
    private func configureIfPresent(_ value: String?, using configure: (String) -> Void) {
        if let value = value {
            configure(value)
        }
    }
    
    private func configurePhoneNumber(phoneNumber: String) {
        configureStackView(stackView: phoneNumberStackView, textView: phoneNumberTextView, text: phoneNumber)
    }

    private func configureWebsite(website: String) {
        configureStackView(stackView: websiteStackView, textView: websiteTextView, text: website)
    }

    private func configureDescription(description: String) {
        configureStackView(stackView: descriptionStackView, label: descriptionLabel, text: description)
    }

    private func configureMap(address: String) {
        configureStackView(stackView: mapStackView, label: mapLabel, text: address)
    }

    private func configureStackView(stackView: UIStackView, textView: UITextView? = nil, label: UILabel? = nil, text: String) {
        stackView.isHidden = false
        textView?.text = text
        label?.text = text
    }
    
    func configureBookMarkButton(isBookMarked: Bool) {
        let imageName = isBookMarked ? "bookmark.fill" : "bookmark"
        let tintColor: UIColor = isBookMarked ? .green100 : .gray80
        
        bookMarkButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        bookMarkButton.tintColor = tintColor
    }
    
    func configureMapView(latitude: Double, longtitude: Double) {
        let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerLocation
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    func copyAddress() -> String? {
        return mapLabel.text
    }
}
