//
//  TravelMemoryDetailEditView.swift
//  TravelTale
//
//  Created by 유림 on 6/11/24.
//

import UIKit

class TravelMemoryDetailEditView: BaseView {
    
    // MARK: - properties
    let travelInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    let locationImageView = UIImageView().then {
        $0.image = UIImage(systemName: "pin")
        $0.tintColor = .gray90
    }
    
    let provinceLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .oaGothic(size: 10, weight: .medium))
    }
    
    let seperatorLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .oaGothic(size: 10, weight: .medium))
    }
    
    private let periodLabel = UILabel().then {
        $0.configureLabel(color: .gray90, font: .oaGothic(size: 10, weight: .medium))
    }
    
    let travelTitleLabel = UILabel().then {
        $0.configureLabel(alignment: .left, font: .pretendard(size: 20, weight: .bold))
    }
    
    let tableView = UITableView()
    
    let confirmButton = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold), text: "선택 완료")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [tableView,
         confirmButton].forEach { self.addSubview($0) }
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}