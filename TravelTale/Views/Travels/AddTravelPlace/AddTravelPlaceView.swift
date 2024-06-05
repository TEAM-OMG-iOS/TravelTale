//
//  AddTravelPlaceView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

class AddTravelPlaceView: BaseView {
    
    // MARK: - Properties
    let pageTitleLabel = UILabel()
    let inputTitleLabel = UILabel()
    let inputBox = UIButton()
//    let backButton = UIButton()
    let cancelButton = UIButton()
    let okButton = UIButton()
    let progressView = UIProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func configureUI() {
        self.backgroundColor = .white
        
        pageTitleLabel.backgroundColor = .clear
        pageTitleLabel.textColor = .blueBlack100
        pageTitleLabel.font = UIFont(name: "OAGothic-ExtraBold", size: 18)
        pageTitleLabel.text = "새 여행 추가"
        pageTitleLabel.textAlignment = .center
        
        inputTitleLabel.backgroundColor = .clear
        inputTitleLabel.textColor = .blueBlack100
        inputTitleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        inputTitleLabel.text = "대표 장소를 선택해주세요"
        
        inputBox.backgroundColor = .gray10
        inputBox.layer.cornerRadius = 24
        inputBox.setTitle("미정", for: .normal)
        inputBox.contentHorizontalAlignment = .left
        inputBox.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        inputBox.setTitleColor(.gray, for: .normal)
        inputBox.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        
//
//        backButton.backgroundColor = .clear
//        backButton.setTitle("<", for: .normal)
//        backButton.setTitleColor(.blueBlack100, for: .normal)
        
        cancelButton.backgroundColor = .gray70
        cancelButton.layer.cornerRadius = 24
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitle("이전", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        
        okButton.backgroundColor = .green100
        okButton.layer.cornerRadius = 24
        okButton.setTitleColor(.white, for: .normal)
        okButton.setTitle("날짜 선택하러 가기", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        
        progressView.progressViewStyle = .default
    }
    
    override func configureHierarchy() {
        
        [pageTitleLabel, inputTitleLabel, inputBox, cancelButton, okButton, progressView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(8)
        }
        inputTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(56)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(21)
        }
        inputBox.snp.makeConstraints { make in
            make.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
//        backButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(70)
//            make.leading.equalToSuperview().offset(0)
//            make.trailing.equalToSuperview().offset(-290)
//            make.bottom.equalToSuperview().offset(-730)
//        }
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-31)
            make.width.equalTo(100)
            make.height.equalTo(52)
        }
        okButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-31)
            make.height.equalTo(52)
        }
    }
}

// MARK: - AddLocationView
class AddLocationView: BaseView {
    
    // MARK: - Properties
    let guideLabel = UILabel()
    let locationList = UITableView()
    var locations: [String] = ["서울특별시", "인천광역시", "부산광역시", "대전광역시", "대구광역시", "울산광역시", "광주광역시", "제주특별자치도", "세종특별자치시", "경기도", "강원도", "충청북도", "충청남도", "경상북도", "경상남도", "전라북도", "전라남도"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func configureUI() {
        self.backgroundColor = .white
        
        guideLabel.text = "대표 여행 장소를 선택해주세요"
        guideLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    override func configureHierarchy() { 
        [guideLabel, locationList].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() { 
        guideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(42)
        }
        locationList.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
