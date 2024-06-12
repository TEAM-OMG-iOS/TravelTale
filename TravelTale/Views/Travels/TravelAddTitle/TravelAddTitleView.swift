//
//  TravelAddTitleView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddTitleView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "xmark")
        $0.tintColor = .gray90
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 제목을 입력해주세요")
    }
    
    let textField = UITextField().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.placeholder = "남자친구와 100일 여행"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.font = .pretendard(size: 16, weight: .medium)
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "장소 선택하러 가기")
        $0.configureView(color: .green10,
                         cornerRadius: 24)
    }
    
    private let progressView = UIView().then {
        $0.configureView(color: .gray20,
                         clipsToBounds: true,
                         cornerRadius: 4)
    }
    
    private let loadingBar = UIView().then {
        $0.configureView(color: .green80,
                         clipsToBounds: true,
                         cornerRadius: 4)
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        okButton.isEnabled = false
    }
    
    override func configureHierarchy() {
        [inputTitleLabel,
         textField,
         okButton,
         progressView].forEach {
            self.addSubview($0)
        }
        
        progressView.addSubview(loadingBar)
    }
    
    override func configureConstraints() {
        progressView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(116)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(8)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.top.height.equalToSuperview()
            $0.width.equalTo(0)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        okButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.top.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(1.0 / 3.0)
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.progressView.layoutIfNeeded()
        })
    }
    
    func buttonColorChanged() {
        if textField.text?.isEmpty != true {
            okButton.isEnabled = true
            okButton.backgroundColor = .green100
        } else {
            okButton.isEnabled = false
            okButton.backgroundColor = .green10
        }
    }
}
