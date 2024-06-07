//
//  TravelAddition.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit
import SnapKit
import Then

final class TravelSelectView: BaseView {
    
    // MARK: - properties
    let loadingBackBar = UIView().then {
        $0.backgroundColor = .gray10
        $0.layer.cornerRadius = 4
    }
    
    let loadingBar = UIView().then {
        $0.backgroundColor = .green80
        $0.layer.cornerRadius = 4
    }
    
    let tableViewLabel = UILabel().then {
        $0.text = "여행을 선택해주세요"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    let tableView = UITableView().then {
        $0.backgroundColor = .red
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
        super.configureUI()
    }
    
    override func configureHierarchy() {
        [loadingBackBar, tableViewLabel, tableView, btnStackView].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
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
            $0.width.equalTo(0)
        }
        
        tableViewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel.snp.bottom).offset(28)
            $0.leading.equalTo(loadingBackBar.snp.leading)
            $0.bottom.equalTo(btnStackView.snp.top)
            $0.width.equalTo(loadingBackBar)
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
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(177)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
