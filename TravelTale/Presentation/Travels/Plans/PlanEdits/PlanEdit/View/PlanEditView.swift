//
//  PlanEditView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/8/24.
//

import UIKit

final class PlanEditView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    let deleteButton = UIBarButtonItem().then {
        $0.style = .done
        $0.title = "삭제"
        $0.tintColor = .gray90
    }
    
    private let travelTitleLabel = UILabel().then {
        $0.configureLabel(color: .black,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 제목")
    }
    
    let textField = UITextField().then {
        $0.configureView(color: .gray5, cornerRadius: 24)
        $0.placeholder = "남자친구와 100일 여행"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
    }
    
    private let travelPlaceLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold),
                          text: "대표 여행지")
    }
    
    private let pickGuideLabel = UILabel().then {
        $0.configureLabel(color: .lightGray,
                          font: .pretendard(size: 14, weight: .light),
                          text: "태그에 표시됩니다")
    }
    
    private let placePickBackView = GrayBackgroundView()
    
    let placePickLabel = UILabel().then {
        $0.text = "서울특별시"
        $0.textColor = .gray90
        $0.textAlignment = .left
    }
    
    let placePickImageButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
    }
    
    private let travelDateLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 날짜")
    }
    
    let resetDateButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        $0.tintColor = .black
    }
    
    let dayRangeButton = UIButton().then {
        $0.titleLabel?.font = .pretendard(size: 16, weight: .medium)
        $0.setTitle("2024.05.08 - 2024.05.11", for: .normal)
        $0.setTitleColor(.gray90, for: .normal)
    }
    
    let datePickButton = UIButton().then {
        $0.configureView(color: .gray5, clipsToBounds: true, cornerRadius: 24)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .medium)
        $0.setTitle("3박 4일", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "완료")
        $0.configureView(color: .green100,
                         cornerRadius: 24)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [travelTitleLabel,
         textField,
         travelPlaceLabel,
         pickGuideLabel,
         placePickBackView,
         travelDateLabel,
         resetDateButton,
         datePickButton,
         okButton].forEach {
            self.addSubview($0)
        }
        [placePickLabel,
         placePickImageButton].forEach {
            placePickBackView.addSubview($0)
        }
        datePickButton.addSubview(dayRangeButton)
    }
    
    override func configureConstraints() {
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(116)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(21)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(travelTitleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        travelPlaceLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(21)
        }
        
        pickGuideLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(104)
            $0.height.equalTo(21)
        }
        
        placePickBackView.snp.makeConstraints {
            $0.top.equalTo(travelPlaceLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        placePickLabel.snp.makeConstraints {
            $0.leading.equalTo(placePickBackView).inset(16)
            $0.centerY.equalTo(placePickBackView)
        }
        
        placePickImageButton.snp.makeConstraints {
            $0.trailing.equalTo(placePickBackView).inset(16)
            $0.centerY.equalTo(placePickBackView)
        }
        
        travelDateLabel.snp.makeConstraints {
            $0.top.equalTo(placePickBackView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(24)
            $0.height.equalTo(21)
        }
        
        resetDateButton.snp.makeConstraints {
            $0.top.equalTo(placePickBackView.snp.bottom).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(19)
            $0.height.equalTo(21)
        }
        
        datePickButton.snp.makeConstraints {
            $0.top.equalTo(travelDateLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        dayRangeButton.snp.makeConstraints {
            $0.trailing.equalTo(datePickButton).inset(16)
            $0.centerY.equalTo(datePickButton)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    func buttonColorChanged() {
        if textField.text?.isEmpty != false {
            okButton.isEnabled = false
            okButton.backgroundColor = .green10
        } else {
            okButton.isEnabled = true
            okButton.backgroundColor = .green100
        }
    }
    
    func updatePlaceLabel(text: Sido) {
        placePickLabel.text = text.name ?? "미정"
        placePickLabel.textColor = .black
    }
    
    func updateDayRangeButton(text: String) {
        dayRangeButton.configureButton(fontColor: .gray90,
                                       font: .pretendard(size: 16, weight: .medium),
                                       text: text)
    }
    
    func updateDatePickButton(text: String) {
        datePickButton.configureButton(font: .pretendard(size: 16, weight: .medium),
                                       text: text)
    }
}

// MARK: - extentions
extension UIButton {
    func buttonConfiguration() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        self.configuration = configuration
    }
}
