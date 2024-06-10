//
//  TravelAddTitleView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddTitleView: BaseView {
    
    // MARK: - Properties
    
    private let pageTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .blueBlack100,font: .oaGothic(size: 18, weight: .heavy), text: "새 여행 추가")
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "여행 제목을 입력해주세요")
    }
    
    let textField = UITextField().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.placeholder = "남자친구와 100일 여행"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
    }
    
    let cancelButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "취소")
        $0.configureView(color: .gray70, cornerRadius: 24)
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "장소 선택하러 가기")
        $0.configureView(color: .green10, cornerRadius: 24)
    }
    
    private let progressView = UIView().then {
        $0.configureView(color: .gray20, clipsToBounds: true, cornerRadius: 4)
    }
    
    private let loadingBar = UIView().then {
        $0.configureView(color: .green80, clipsToBounds: true, cornerRadius: 4)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func configureUI() {
        super.configureUI()
        
        okButton.isEnabled = false
    }
    
    override func configureHierarchy() {
        
        [pageTitleLabel, inputTitleLabel, textField, cancelButton, okButton, progressView].forEach {
            self.addSubview($0)
        }
        progressView.addSubview(loadingBar)
    }
    
    override func configureConstraints() {
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(8)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(0)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-31)
            $0.width.equalTo(100)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {            
            $0.leading.equalTo(cancelButton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-31)
            $0.height.equalTo(52)
        }
    }
    
    @objc func buttonColorChanged() {
        if textField.text?.isEmpty != true {
            okButton.isEnabled = true
            okButton.backgroundColor = .green100
        } else {
            okButton.isEnabled = false
            okButton.backgroundColor = .green10
        }
    }
}
