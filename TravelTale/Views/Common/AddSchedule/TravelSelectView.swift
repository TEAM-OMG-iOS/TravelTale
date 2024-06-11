//
//  TravelAddition.swift
//  TravelTale
//
//  Created by Kinam on 6/4/24.
//

import UIKit

final class TravelSelectView: BaseView {
    
    // MARK: - properties
    let naviTitle = UILabel().then {
        $0.configureLabel(font: .oaGothic(size: 18, weight: .heavy), text: "내 여행에 추가")
    }
    
    private let exitButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = UIColor(red: 0.39, green: 0.39, blue: 0.39, alpha: 1.00)
    }
    
    private let leftButtonView = UIView().then {
        $0.frame = CGRect(x: 20, y: 0, width: 50, height: 50)
    }
    
    lazy var leftBarButtonItem = UIBarButtonItem(customView: leftButtonView)
    
    private let loadingBackBar = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 4)
    }
    
    private let loadingBar = UIView().then {
        $0.configureView(color: .green80, cornerRadius: 4)
    }
    
    private let tableViewLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold), text: "여행을 선택해주세요")
    }
    
    let tableView = UITableView().then {
        $0.configureView(color: .clear, cornerRadius: 4)
        $0.separatorStyle = .none
    }
    
    let nextBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "일정 생성하러 가기")
        $0.configureView(color: .green10, cornerRadius: 24)
        $0.isEnabled = false
    }
    
    let cellbackgroundView = UIView().then {
        $0.configureView(color: .green10, cornerRadius: 15)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [loadingBackBar, tableViewLabel, tableView, nextBtn].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
        }
        
        [exitButton].forEach {
            self.leftButtonView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        exitButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(20)
        }
        
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
            $0.width.equalTo(1)
        }
        
        tableViewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel.snp.bottom).offset(28)
            $0.leading.equalTo(loadingBackBar.snp.leading)
            $0.bottom.equalTo(nextBtn.snp.top)
            $0.width.equalTo(loadingBackBar)
        }
        
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(31)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview()
            let halfwidth = loadingBackBar.frame.size.width / 2
            $0.width.equalTo(halfwidth)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func updateButtonState() {
            if tableView.indexPathForSelectedRow == nil {
                nextBtn.isEnabled = false
                nextBtn.configureView(color: .green10, cornerRadius: 24)
            } else {
                nextBtn.isEnabled = true
                nextBtn.configureView(color: .green100, cornerRadius: 24)
            }
        }
}
