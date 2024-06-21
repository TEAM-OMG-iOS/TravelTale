//
//  DiscoveryRegionView.swift
//  TravelTale
//
//  Created by 배지해 on 6/11/24.
//

import UIKit

final class DiscoveryRegionView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let sidoBackground = GrayBackgroundView()
    
    private let sidoLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "시/도")
    }
    
    let sidoButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
    }
    
    private let currentSidoLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular))
    }
    
    private let sigunguBackground = GrayBackgroundView()
    
    private let sigunguLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold),
                          text: "시/군/구")
    }
    
    let sigunguButton = UIButton().then {
        $0.setImage(.init(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .gray90
        $0.isEnabled = false
    }
    
    private let currentSigunguLabel = UILabel().then {
        $0.configureLabel(color: .gray80,
                          font: .pretendard(size: 16, weight: .regular))
    }
    
    let submitButton = GreenButton().then {
        $0.configureButton(fontColor: .white,
                           font: .pretendard(size: 20, weight: .heavy),
                           text: "완료")
        $0.isEnabled = false
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        updateSubmitButtonAppearance()
    }
    
    override func configureHierarchy() {
        self.addSubview(sidoBackground)
        self.addSubview(sidoLabel)
        self.addSubview(sidoButton)
        self.addSubview(currentSidoLabel)
        self.addSubview(sigunguBackground)
        self.addSubview(sigunguLabel)
        self.addSubview(sigunguButton)
        self.addSubview(currentSigunguLabel)
        self.addSubview(submitButton)
    }
    
    override func configureConstraints() {
        sidoBackground.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(safeAreaLayoutGuide).offset(44)
        }
        
        sidoLabel.snp.makeConstraints {
            $0.leading.equalTo(sidoBackground).offset(16)
            $0.centerY.equalTo(sidoBackground)
        }
        
        sidoButton.snp.makeConstraints {
            $0.trailing.equalTo(sidoBackground).offset(-16)
            $0.verticalEdges.equalTo(sidoBackground).inset(12)
            $0.height.equalTo(sidoButton.snp.width)
        }
        
        currentSidoLabel.snp.makeConstraints {
            $0.trailing.equalTo(sidoButton.snp.leading).offset(-4)
            $0.centerY.equalTo(sidoBackground)
        }
        
        sigunguBackground.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(sidoBackground.snp.bottom).offset(24)
        }
        
        sigunguLabel.snp.makeConstraints {
            $0.leading.equalTo(sigunguBackground).offset(16)
            $0.centerY.equalTo(sigunguBackground)
        }
        
        sigunguButton.snp.makeConstraints {
            $0.trailing.equalTo(sigunguBackground).offset(-16)
            $0.verticalEdges.equalTo(sigunguBackground).inset(12)
            $0.height.equalTo(sigunguButton.snp.width)
        }
        
        currentSigunguLabel.snp.makeConstraints {
            $0.trailing.equalTo(sigunguButton.snp.leading).offset(-4)
            $0.centerY.equalTo(sigunguBackground)
        }
        
        submitButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func selectSido(sidoName: String) {
        let isSejongCity = (sidoName == "세종특별자치시")
        
        updateLabel(label: currentSidoLabel, text: sidoName)
        currentSigunguLabel.text = isSejongCity ? "" : "시/구/군을 선택해주세요."
        currentSigunguLabel.textColor = isSejongCity ? .black : .gray80
        sigunguButton.isEnabled = !isSejongCity
        
        updateSubmitButtonState(sido: sidoName, sigungu: nil)
    }
    
    func selectSigungu(sigunguName: String) {
        updateLabel(label: currentSigunguLabel, text: sigunguName)
        updateSubmitButtonState(sido: "서울", sigungu: sigunguName)
    }
    
    private func updateLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
    }
    
    private func updateSubmitButtonAppearance() {
        submitButton.backgroundColor = submitButton.isEnabled ? .green100 : .green10
    }
    
    func updateSubmitButtonState(sido: String?, sigungu: String?) {
        guard let sido = sido else {
            submitButton.isEnabled = false
            updateSubmitButtonAppearance()
            return
        }
        
        submitButton.isEnabled = sido == "세종특별자치시" || sigungu != nil
        updateSubmitButtonAppearance()
    }
    
    func setSidoAndSigunguLabel(sidoText: String, sigunguText: String) {
        currentSidoLabel.text = sidoText
        currentSigunguLabel.text = sigunguText
    }
}
