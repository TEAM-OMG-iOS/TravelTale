//
//  TravelRescheduleView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/8/24.
//

import UIKit

final class TravelRescheduleView: BaseView {
    
    // MARK: - properties
    private let pageTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .center,
                          color: .black,
                          font: .oaGothic(size: 18, weight: .heavy),
                          text: "일정 변경")
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
        $0.leftViewMode = .always
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
    }
    
    private let travelPlaceLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold),
                          text: "대표 여행지")
    }
    
    private let placePickBackView = UIView().then {
        $0.configureView(color: .gray5, clipsToBounds: true, cornerRadius: 20)
    }
    
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
    
    let dateLabel = UILabel().then {
        $0.font = .pretendard(size: 16, weight: .medium)
        $0.text = "2024.05.08 - 2024.05.11"
        $0.textColor = .gray90
    }
    
    let datePickButton = UIButton().then {
        $0.configureView(color: .gray5, clipsToBounds: true, cornerRadius: 24)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.setTitle("3박 4일", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    private let returnDate = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.clockwise")
        $0.tintColor = .black
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "완료")
        $0.configureView(color: .green10,
                         cornerRadius: 24)
    }
    
    let alert = UIAlertController(title: "경고", message: """
수정된 일정만큼 일부 삭제될 수 있습니다.
그대로 진행하시겠습니까?
""", preferredStyle: UIAlertController.Style.alert)
    
    let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
    let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        alert.addAction(cancel)
        alert.addAction(ok)
    }
    
    override func configureHierarchy() {
        [pageTitleLabel,
         travelTitleLabel,
         textField,
         travelPlaceLabel,
         placePickBackView,
         travelDateLabel,
         datePickButton,
         okButton].forEach {
            self.addSubview($0)
        }
        [placePickLabel,
         placePickImageButton].forEach {
            placePickBackView.addSubview($0)
        }        
        datePickButton.addSubview(dateLabel)
    }
    
    override func configureConstraints() {
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        travelTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(38)
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
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(21)
        }
        
        datePickButton.snp.makeConstraints {
            $0.top.equalTo(travelDateLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        dateLabel.snp.makeConstraints {
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
        if textField.text?.isEmpty != true {
            okButton.isEnabled = true
            okButton.backgroundColor = .green100
        } else {
            okButton.isEnabled = false
            okButton.backgroundColor = .green10
        }
    }
}

//MARK: - extention UIButton
extension UIButton {
    func buttonConfiguration() {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        self.configuration = configuration
    }
}
