//
//  PlaceDetailAlertView.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class PlaceDetailAlertView: BaseView {
    
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
    
    let callButton = UIButton().then {
        $0.configureButton(fontColor: .black, font: .pretendard(size: 14, weight: .medium), text: "전화 걸기")
        $0.contentHorizontalAlignment = .left
    }
    
    private let firstLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    let copyPhoneNumberButton = UIButton().then {
        $0.configureButton(fontColor: .black, font: .pretendard(size: 14, weight: .medium), text: "전화번호 복사하기")
        $0.contentHorizontalAlignment = .left
    }
    
    private let secondLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    let cancelButton = UIButton().then {
        $0.configureButton(fontColor: .gray90, font: .pretendard(size: 14, weight: .medium), text: "취소")
    }
    
    // MARK: - methods
    override func configureUI() {
        self.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(callButton)
        contentView.addSubview(firstLine)
        contentView.addSubview(copyPhoneNumberButton)
        contentView.addSubview(secondLine)
        contentView.addSubview(cancelButton)
    }
    
    override func configureConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(60)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        callButton.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        firstLine.snp.makeConstraints {
            $0.top.equalTo(callButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        copyPhoneNumberButton.snp.makeConstraints {
            $0.top.equalTo(firstLine.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        secondLine.snp.makeConstraints {
            $0.top.equalTo(copyPhoneNumberButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(secondLine.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setPhoneNumber(phoneNumber: String) {
        phoneNumberLabel.text = phoneNumber
    }
}
