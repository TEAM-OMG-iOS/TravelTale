//
//  TravelAddPlaceView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddPlaceView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "xmark")
        $0.tintColor = .gray90
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left,
                          color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "대표 장소를 선택해주세요")
    }
    
    let placePickButton = UIButton().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.titleLabel?.font = .pretendard(size: 16, weight: .medium)
        $0.setTitle("미정", for: .normal)
        $0.setTitleColor(.gray90, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    let cancelButton = GrayButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "이전")
    }
    
    let okButton = GreenButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 18, weight: .bold),
                           text: "날짜 선택하러 가기")
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
         placePickButton,
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
            $0.width.equalTo(118)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        placePickButton.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(okButton.snp.leading).offset(-15)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
            $0.width.equalTo(cancelButton.snp.width).multipliedBy(2)
        }
    }
    
    func startLoadingAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.loadingBar.transform = CGAffineTransform(scaleX: 3, y: 1)
        })
    }
}
