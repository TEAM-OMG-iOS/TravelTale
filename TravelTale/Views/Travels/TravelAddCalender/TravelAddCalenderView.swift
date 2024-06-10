//
//  TravelAddCalenderView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class TravelAddCalenderView: BaseView {
    
    // MARK: - Properties
    
    private lazy var calenderView = CalendarView(initialContent: makeContent())

    private let pageTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .blueBlack100, font: .oaGothic(size: 18, weight: .heavy), text: "새 여행 추가")
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "여행 제목을 입력해주세요")
    }
    
    private let startLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .pretendard(size: 16, weight: .medium), text: "출발일 | ")
    }
    
    private let endLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .pretendard(size: 16, weight: .medium), text: "도착일 | ")
    }
    
    let cancelButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "이전")
        $0.configureView(color: .gray70, cornerRadius: 24)
    }
    
    private let okButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "날짜 선택하러 가기")
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
    }
    
    override func configureHierarchy() {
        
        [pageTitleLabel, inputTitleLabel, startLabel, endLabel, cancelButton, okButton, progressView, calenderView].forEach {
            self.addSubview($0)
        }
        progressView.addSubview(loadingBar)
    }
    
    override func configureConstraints() {
        
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(24)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(8)
        }
        
        loadingBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(236)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }

        startLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(32)
            $0.width.equalTo(172)
            $0.height.equalTo(48)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(24)
            $0.leading.equalTo(startLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(48)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-31)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-31)
            $0.leading.equalTo(cancelButton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
        
        calenderView.snp.makeConstraints {
            $0.top.equalTo(endLabel.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalTo(okButton.snp.top).offset(-30)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(3.0 / 3.0)
        }
        UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.progressView.layoutIfNeeded()
            
        }, completion: nil)
    }
}
