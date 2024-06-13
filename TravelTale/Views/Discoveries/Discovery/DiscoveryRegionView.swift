//
//  DiscoveryRegionView.swift
//  TravelTale
//
//  Created by 배지해 on 6/11/24.
//

import UIKit

final class DiscoveryRegionView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let cityBackground = GrayBackgroundView()
    
    private let cityLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "시/도")
    }
    
    let cityButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
    }
    
    private let currentCityLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular))
    }
    
    private let districtBackground = GrayBackgroundView()
    
    private let districtLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "구/군")
    }
    
    let districtButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
        $0.isEnabled = false
    }
    
    private let currentDistrictLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular))
    }
    
    let submitButton = GreenButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 20, weight: .heavy),
                           text: "완료")
        $0.isEnabled = false
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        updateSubmitButtonAppearance()
    }
    
    override func configureHierarchy() {
        self.addSubview(cityBackground)
        self.addSubview(cityLabel)
        self.addSubview(cityButton)
        self.addSubview(currentCityLabel)
        self.addSubview(districtBackground)
        self.addSubview(districtLabel)
        self.addSubview(districtButton)
        self.addSubview(currentDistrictLabel)
        self.addSubview(submitButton)
    }
    
    override func configureConstraints() {
        cityBackground.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(44)
        }
        
        cityLabel.snp.makeConstraints {
            $0.leading.equalTo(cityBackground).offset(16)
            $0.centerY.equalTo(cityBackground)
        }
        
        cityButton.snp.makeConstraints {
            $0.trailing.equalTo(cityBackground).offset(-16)
            $0.verticalEdges.equalTo(cityBackground).inset(12)
            $0.height.equalTo(cityButton.snp.width)
        }
        
        currentCityLabel.snp.makeConstraints {
            $0.trailing.equalTo(cityButton.snp.leading).offset(-4)
            $0.centerY.equalTo(cityBackground)
        }
        
        districtBackground.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(cityBackground.snp.bottom).offset(24)
        }
        
        districtLabel.snp.makeConstraints {
            $0.leading.equalTo(districtBackground).offset(16)
            $0.centerY.equalTo(districtBackground)
        }
        
        districtButton.snp.makeConstraints {
            $0.trailing.equalTo(districtBackground).offset(-16)
            $0.verticalEdges.equalTo(districtBackground).inset(12)
            $0.height.equalTo(districtButton.snp.width)
        }
        
        currentDistrictLabel.snp.makeConstraints {
            $0.trailing.equalTo(districtButton.snp.leading).offset(-4)
            $0.centerY.equalTo(districtBackground)
        }
        
        submitButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func selectCity(cityName: String) {
        let isSejongCity = (cityName == "세종특별자치시")
        
        updateLabel(label: currentCityLabel, text: cityName)
        currentDistrictLabel.text = isSejongCity ? "" : "구/군을 선택해주세요."
        currentDistrictLabel.textColor = isSejongCity ? .black : .gray80
        districtButton.isEnabled = !isSejongCity
    }
    
    func selectDistrict(districtName: String) {
        updateLabel(label: currentDistrictLabel, text: districtName)
    }
    
    private func updateLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
    }
    
    func updateSubmitButtonAppearance() {
        submitButton.backgroundColor = submitButton.isEnabled ? .green100 : .green10
    }
    
    func setCityAndDistrictLabels(cityName: String, districtName: String) {
        currentCityLabel.text = cityName
        currentDistrictLabel.text = districtName
    }
}
