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
    private let imageViewHeight: CGFloat = 300
    private let buttonHeight: CGFloat = 48
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = false
        $0.isDirectionalLockEnabled = true
    }
    
    private let contentView = UIView()
    
    let backButton = UIButton().then {
        $0.tintColor = .gray90
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
    }
    
    let detailBlurImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private let detailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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
    
    let phoneNumberButton = UIButton().then {
        $0.contentHorizontalAlignment = .left
    }
    
    private let phoneNumberStackView = UIStackView().then {
        $0.spacing = 16
        $0.isHidden = true
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let websiteImage = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "globe")
    }
    
    let websiteButton = UIButton().then {
        $0.contentHorizontalAlignment = .left
    }
    
    private let websiteStackView = UIStackView().then {
        $0.spacing = 16
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
        $0.configureLabel(color: .gray120, 
                          font: .pretendard(size: 14, weight: .medium),
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
        $0.configureLabel(color: .gray120,
                          font: .pretendard(size: 14, weight: .medium),
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
        $0.alignment = .top
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    let mapView = MKMapView().then {
        $0.isHidden = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray20.cgColor
        $0.configureView(clipsToBounds: true, cornerRadius: 15)
    }
    
    private let detailStackView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let buttonBackground = UIView().then {
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
    
    private let buttonLine = UIView().then {
        $0.configureView(color: .gray20)
    }
    
    let addButton = UIButton().then {
        $0.configureView(color: .green100, clipsToBounds: true, cornerRadius: 15)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(detailBlurImageView)
        makeBlurEffect(to: detailBlurImageView)
        detailBlurImageView.addSubview(detailImageView)
        
        contentView.addSubview(placeName)
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        contentView.addSubview(line)
        
        phoneNumberStackView.addArrangedSubview(phoneNumberImage)
        phoneNumberStackView.addArrangedSubview(phoneNumberButton)
        detailStackView.addArrangedSubview(phoneNumberStackView)
        
        websiteStackView.addArrangedSubview(websiteImage)
        websiteStackView.addArrangedSubview(websiteButton)
        detailStackView.addArrangedSubview(websiteStackView)
        
        descriptionStackView.addArrangedSubview(descriptionImage)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        detailStackView.addArrangedSubview(descriptionStackView)
        
        mapStackView.addArrangedSubview(mapImage)
        mapStackView.addArrangedSubview(mapLabel)
        mapStackView.addArrangedSubview(copyAddressButton)
        detailStackView.addArrangedSubview(mapStackView)
        
        contentView.addSubview(detailStackView)
        contentView.addSubview(mapView)
        
        addSubview(buttonBackground)
        buttonBackground.addSubview(bookMarkButton)
        buttonBackground.addSubview(buttonLine)
        buttonBackground.addSubview(addButton)
        
        contentView.addSubview(backButton)
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
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(24)
            $0.width.equalTo(16)
        }
        
        detailBlurImageView.snp.makeConstraints {
            $0.height.equalTo(imageViewHeight)
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        detailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeName.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(detailBlurImageView.snp.bottom).offset(16)
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
    
    func bind(placeDetail: PlaceDetail, url: String?, isBookMarked: Bool) {
        if let image = placeDetail.firstImage, let image = URL(string: image) {
            detailBlurImageView.kf.setImage(with: image)
            detailImageView.kf.setImage(with: image)
        } else {
            detailBlurImageView.image = .detailPlaceThumnail
            detailImageView.image = .detailPlaceThumnail
        }
        
        if let name = placeDetail.title {
            self.placeName.text = name
        }
        
        if let typeId = placeDetail.contentTypeId {
            configureCategory(category: typeId)
        }
        
        if let phoneNumber = placeDetail.tel {
            if phoneNumber != "" {
                configureStackView(stackView: phoneNumberStackView, button: phoneNumberButton, text: phoneNumber)
            }
        }
        
        if let website = url {
            if website != "" {
                configureStackView(stackView: websiteStackView, button: websiteButton, text: website)
            }
        }
        
        if let description = placeDetail.overview {
            if description != "" {
                configureStackView(stackView: descriptionStackView, label: descriptionLabel, text: description)
            }
        }
        
        let address = [placeDetail.addr1, placeDetail.addr2].compactMap { $0 }.joined(separator: " ")
        
        if address != "" {
            configureStackView(stackView: mapStackView, label: mapLabel, text: address)
        }
        
        configureBookMarkButton(isBookMarked: isBookMarked)
        
        if let mapx = placeDetail.mapx, let mapy = placeDetail.mapy,
            let longitude = Double(mapx), let latitude = Double(mapy) {
            configureMapView(latitude: latitude, longitude: longitude)
        }
    }
    
    private func configureCategory(category: String) {
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
    
    private func configureStackView(stackView: UIStackView, button: UIButton? = nil, label: UILabel? = nil, text: String) {
        stackView.isHidden = false
        
        let attributedString = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                                             .font: UIFont.pretendard(size: 14, weight: .medium),
                                                                             .foregroundColor: UIColor.blue])
        button?.setAttributedTitle(attributedString, for: .normal)
        
        label?.text = text
    }
    
    func configureBookMarkButton(isBookMarked: Bool) {
        let imageName = isBookMarked ? "bookmark.fill" : "bookmark"
        let tintColor: UIColor = isBookMarked ? .green100 : .gray80
        
        bookMarkButton.setBackgroundImage(UIImage(systemName: imageName), for: .normal)
        bookMarkButton.tintColor = tintColor
    }
    
    func configureMapView(latitude: Double, longitude: Double) {
        guard latitude >= -90, latitude <= 90, longitude >= -180, longitude <= 180 else {
            print("유효하지 않은 위도, 경도 값입니다.")
            return
        }
        
        mapView.isHidden = false
        
        let centerLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: centerLocation, latitudinalMeters: 400, longitudinalMeters: 400)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = centerLocation
        
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    func copyAddress() -> String? {
        return mapLabel.text
    }
    
    func makeBlurEffect(to imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.alpha = 1
        visualEffectView.frame = imageView.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        detailBlurImageView.addSubview(visualEffectView)
    }
    
    func setAddButton(text: String) {
        addButton.configureButton(fontColor: .white,
                                  font: .pretendard(size: 18, weight: .bold),
                                  text: text)
    }
}
