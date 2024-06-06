//
//  TravelAdditionView2.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit
import SnapKit
import Then

final class TravelPlaceAddView2: BaseView {
    
    // MARK: - properties
    let loadingBackBar = UIView().then {
        $0.backgroundColor = .gray10
        $0.layer.cornerRadius = 4
    }
    let loadingBar = UIView().then {
        $0.backgroundColor = .green80
        $0.layer.cornerRadius = 4
    }
    let ViewLabel = UILabel().then {
        $0.text = "일정을 생성해주세요"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    let placeView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        $0.layer.cornerRadius = 20
    }
    let placeTitle = UILabel().then {
        $0.text = "장소"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    let placeContents = UILabel().then {
        $0.text = "설빙 석촌호수 동호점"
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
    }
    let scheduleView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        $0.layer.cornerRadius = 20
    }
    let scheduleTitle = UILabel().then {
        $0.text = "일정"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    let scheduleContents = UILabel().then {
        $0.text = "일정을 선택하세요"
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.textColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.00)
    }
    let startTimeView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        $0.layer.cornerRadius = 20
    }
    let startTimeTitle = UILabel().then {
        $0.text = "시작 시간"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    let startTimeContents = UILabel().then {
        $0.text = "시간을 선택하세요"
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.textColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.00)
    }
    let memoView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        $0.layer.cornerRadius = 20
    }
    let memoTitle = UILabel().then {
        $0.text = "메모"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    let memoTV = UITextView().then {
        $0.textAlignment = .natural
        $0.backgroundColor = .clear
    }
    let btnStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 15
    }
    let cancelBtn = GrayButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        $0.titleLabel?.textColor = .white
    }
    let nextBtn = GreenButton().then {
        $0.backgroundColor = .green10
        $0.setTitle("일정 생성하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        $0.titleLabel?.textColor = .white
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        self.backgroundColor = .white
    }
    
    override func configureHierarchy() {
        [loadingBackBar, ViewLabel, placeView, scheduleView, startTimeView, memoView ,btnStackView].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
        }
        
        [placeTitle, placeContents].forEach {
            self.placeView.addSubview($0)
        }
        
        [scheduleTitle, scheduleContents].forEach {
            self.scheduleView.addSubview($0)
        }
        
        [startTimeTitle, startTimeContents].forEach {
            self.startTimeView.addSubview($0)
        }
        
        [memoTitle, memoTV].forEach {
            self.memoView.addSubview($0)
        }
        
        [cancelBtn, nextBtn].forEach {
            self.btnStackView.addArrangedSubview($0)
        }
    }
    
    override func configureConstraints() {
        loadingBackBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(18)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(19.5)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(177)
        }
        
        ViewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(ViewLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        placeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleView.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(placeView.snp.horizontalEdges)
            $0.height.equalTo(placeView.snp.height)
        }
        
        scheduleTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeView.snp.makeConstraints {
            $0.top.equalTo(scheduleView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(scheduleView.snp.horizontalEdges)
            $0.height.equalTo(scheduleView.snp.height)
        }
        
        startTimeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        memoView.snp.makeConstraints {
            $0.top.equalTo(startTimeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(startTimeView.snp.horizontalEdges)
            $0.bottom.greaterThanOrEqualTo(btnStackView.snp.top)
        }
        
        memoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        memoTV.snp.makeConstraints {
            $0.top.equalTo(memoTitle.snp.bottom)
            $0.horizontalEdges.equalTo(memoTitle.snp.horizontalEdges)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        btnStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(26)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(110)
        }
        
        nextBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(228)
        }
    }
    
     func startLoadingAnimation() {
         self.loadingBar.snp.remakeConstraints {
             $0.width.equalTo(354)
         }
         UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.loadingBar.layoutIfNeeded()
            
        }, completion: nil)
    }
}

