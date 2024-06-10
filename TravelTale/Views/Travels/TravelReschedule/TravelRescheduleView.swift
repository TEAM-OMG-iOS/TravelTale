//
//  TravelRescheduleView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/8/24.
//

import UIKit

final class TravelRescheduleView: BaseView {
    
    // MARK: - Properties
    
    private let pageTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .blueBlack100,font: .oaGothic(size: 18, weight: .heavy), text: "일정 변경")
    }
    
    private let travelTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "여행 제목")
    }
    
    let textField = UITextField().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.placeholder = "남자친구와 100일 여행"
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        $0.leftViewMode = .always
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
    }
    
    private let travelPlaceLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "대표 여행지")
    }
    
    let placePickButton = UIButton().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.setTitle("미정", for: .normal)
        $0.setTitleColor(.gray90, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    private let travelDateLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "여행 날짜")
    }
    
    let datePickButton = UIButton().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.setTitle("미정", for: .normal)
        $0.setTitleColor(.gray90, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "완료")
        $0.configureView(color: .green10, cornerRadius: 24)
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
        self.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        [pageTitleLabel, 
         travelTitleLabel,
         textField,
         travelPlaceLabel,
         placePickButton,
         travelDateLabel,
         datePickButton,
         okButton].forEach { self.addSubview($0)}
    }
    
    override func configureConstraints() {
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(38)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(travelTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        
        travelPlaceLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }
        
        placePickButton.snp.makeConstraints {
            $0.top.equalTo(travelPlaceLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        
        travelDateLabel.snp.makeConstraints {
            $0.top.equalTo(placePickButton.snp.bottom).offset(38)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }
        
        datePickButton.snp.makeConstraints {
            $0.top.equalTo(travelDateLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-31)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
    }
}

//MARK: - Extention UIButton
extension UIButton {
    func buttonConfiguration() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        self.configuration = configuration
    }
}
