//
//  AddTravelTitleView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

class AddTravelTitleView: BaseView {
    
    // MARK: - Properties
    let pageTitleLabel = UILabel()
    let inputTitleLabel = UILabel()
    let textField = UITextField()
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
        inputTitleLabel.text = "여행 제목을 입력해주세요"
        
        textField.backgroundColor = .gray10
        textField.layer.cornerRadius = 24
        textField.placeholder = "남자친구와 100일 여행"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.font = UIFont(name: "Pretendard-Medium", size: 16)
        
//        
//        backButton.backgroundColor = .clear
//        backButton.setTitle("<", for: .normal)
//        backButton.setTitleColor(.blueBlack100, for: .normal)
        
        cancelButton.backgroundColor = .gray70
        cancelButton.layer.cornerRadius = 24
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        
        okButton.backgroundColor = .green10
        okButton.layer.cornerRadius = 24
        okButton.setTitleColor(.white, for: .normal)
        okButton.setTitle("장소 선택하러 가기", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        
        progressView.progressViewStyle = .default
    }
    
    override func configureHierarchy() {
        
        [pageTitleLabel, inputTitleLabel, textField, cancelButton, okButton, progressView].forEach {
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
        textField.snp.makeConstraints { make in
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
//#Preview {
//    AddTravelTitleView()
//}
