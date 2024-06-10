//
//  TravelAddPlaceView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddPlaceView: BaseView {
    
    // MARK: - Properties
    
    private let pageTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .blueBlack100, font: .oaGothic(size: 18, weight: .heavy), text: "새 여행 추가")
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left, color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold), text: "대표 장소를 선택해주세요")
    }
    
    let placePickButton = UIButton().then {
        $0.configureView(color: .gray10, cornerRadius: 24)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.setTitle("미정", for: .normal)
        $0.setTitleColor(.gray90, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.buttonConfiguration()
    }
    
    let cancelButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "이전")
        $0.configureView(color: .gray70, cornerRadius: 24)
    }
    
    let okButton = UIButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "날짜 선택하러 가기")
        $0.configureView(color: .green100, cornerRadius: 24)
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
        
        [pageTitleLabel, inputTitleLabel, placePickButton, cancelButton, okButton, progressView].forEach {
            self.addSubview($0)
        }
        progressView.addSubview(loadingBar)
    }
    
    override func configureConstraints() {
        pageTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(pageTitleLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(8)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(118)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(21)
        }
        
        placePickButton.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-31)
            $0.width.equalTo(100)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {
            $0.leading.equalTo(cancelButton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-31)
            $0.height.equalTo(52)
        }
    }
}

// MARK: - AddLocationView

class AddLocationView: BaseView {
    
    // MARK: - Properties
    
    let guideLabel = UILabel().then {
        $0.text = "대표 여행 장소를 선택해주세요"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .darkGray
    }
    
    var locations: [String] = []
    
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
        [guideLabel, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(39)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
