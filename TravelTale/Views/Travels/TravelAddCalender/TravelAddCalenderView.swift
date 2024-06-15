//
//  TravelAddCalenderView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class TravelAddCalenderView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "xmark")
        $0.tintColor = .gray90
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 날짜를 선택해주세요")
    }
    
    private let startLabel = UILabel().then {
        $0.configureLabel(color: .gray90,
                          font: .pretendard(size: 16, weight: .medium),
                          text: "출발일 |")
    }
    
    let endLabel = UILabel().then {
        $0.configureLabel(color: .gray90,
                          font: .pretendard(size: 16, weight: .medium),
                          text: "도착일 |")
    }
    
    let cancelButton = GrayButton().then {
        $0.configureButton(fontColor: .white,
                           font: UIFont.pretendard(size: 18, weight: .bold),
                           text: "이전")
    }
    
    let okButton = UIButton().then {
        $0.tintColor = .white
        $0.titleLabel?.font = .pretendard(size: 18, weight: .bold)
        $0.setTitle("날짜 선택하러 가기", for: .normal)
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
    }
    
    override func configureHierarchy() {
        [inputTitleLabel,
         startLabel,
         endLabel,
         cancelButton,
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
            $0.width.equalTo(progressView.snp.width).multipliedBy(0.66)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        startLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(172)
            $0.height.equalTo(48)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(172)
            $0.height.equalTo(48)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(okButton.snp.leading).offset(-15)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(52)
            $0.width.equalTo(cancelButton.snp.width).multipliedBy(2)
        }
    }
    
    func startLoadingAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.loadingBar.transform = CGAffineTransform(scaleX: 3, y: 1)
        })
    }
    
    func setStartDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        startLabel.text = "출발일 | \(dateString)"
    }
    
    func setEndDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        endLabel.text = "도착일 | \(dateString)"
    }
}
