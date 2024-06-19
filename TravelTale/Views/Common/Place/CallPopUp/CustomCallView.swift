//
//  CustomCallView.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class CustomCallView: BaseView {
    
    // MARK: - properties
    private let backgroundView = UIView().then {
        $0.configureView(color: .black)
        $0.isOpaque = false
        $0.alpha = 0.3
    }
    
    private let contentView = UIView().then {
        $0.configureView(color: .white, clipsToBounds: true, cornerRadius: 5)
    }

    private let phoneNumberLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 16, weight: .bold))
    }
    
    private let callLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 14, weight: .medium), text: "전화 걸기")
    }
    
    private let firstLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    private let pastePhoneNumberLabel = UILabel().then {
        $0.configureLabel(color: .black, font: .pretendard(size: 14, weight: .medium), text: "전화번호 복사하기")
    }
    
    private let secondLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    let cancelButton = UIButton().then {
        $0.configureButton(fontColor: .gray90, font: .pretendard(size: 14, weight: .medium), text: "취소")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(contentView)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(callLabel)
        contentView.addSubview(firstLine)
        contentView.addSubview(pastePhoneNumberLabel)
        contentView.addSubview(secondLine)
        contentView.addSubview(cancelButton)
    }
    
    override func configureConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(60)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        callLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        firstLine.snp.makeConstraints {
            $0.top.equalTo(callLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        pastePhoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(firstLine.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        secondLine.snp.makeConstraints {
            $0.top.equalTo(pastePhoneNumberLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(secondLine.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func bind(phoneNumber: String) {
        phoneNumberLabel.text = phoneNumber
    }
}
