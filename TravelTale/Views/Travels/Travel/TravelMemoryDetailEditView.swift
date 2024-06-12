//
//  TravelMemoryDetailEditView.swift
//  TravelTale
//
//  Created by 유림 on 6/11/24.
//

import UIKit

class TravelMemoryDetailEditView: BaseView {
    
    // MARK: - properties
    let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    let locationImageView = UIImageView().then {
        $0.image = UIImage(systemName: "pin")
        $0.tintColor = .gray100
        $0.contentMode = .scaleAspectFit
    }
    
    let provinceLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
    }
    
    let separatorLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray100, font: .oaGothic(size: 10, weight: .medium))
    }
    
    let travelTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left, font: .pretendard(size: 20, weight: .bold))
    }
    
    let borderLine = UIView().then {
        $0.configureView(color: .gray10)
    }
    
    private let recordView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let recordTitleLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "기록")
    }
    
    let recordTextView = UITextView().then {
        $0.configureView(color: .clear)
        $0.textAlignment = .natural
        $0.text = "기록하고 싶은 내용을 작성해주세요"
        $0.textColor = .lightGray
    }
    
    let collectionView = UICollectionView()
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
    }
    
    let formerButton = GrayButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "이전")
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    let confirmButton = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "선택 완료")
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelInfoStackView,
         travelTitleLabel,
         borderLine,
         recordView,
         collectionView,
         buttonStackView].forEach { self.addSubview($0) }
        
        [locationImageView,
        provinceLabel,
        separatorLabel,
         periodLabel].forEach { travelInfoStackView.addArrangedSubview($0) }
        
        [recordTitleLabel,
         recordTextView].forEach { recordView.addSubview($0) }
        
        [formerButton,
         confirmButton].forEach { buttonStackView.addArrangedSubview($0) }
        
    }
    
    override func configureConstraints() {
        let phoneWidth = UIScreen.main.bounds.width
        let horizontalInset = 20
        
        travelInfoStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        locationImageView.snp.makeConstraints {
            $0.size.equalTo(12)
        }
        
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalTo(travelInfoStackView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(travelTitleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        recordView.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(36)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.height.equalTo(208)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().offset(16)
        }
        
        recordTextView.snp.makeConstraints {
            $0.top.equalTo(recordTitleLabel).offset(8)
            $0.bottom.horizontalEdges.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(recordView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.height.equalTo(82)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(horizontalInset)
        }
        
        formerButton.snp.makeConstraints {
            $0.width.equalTo(phoneWidth / 3)
        }
    }
}
