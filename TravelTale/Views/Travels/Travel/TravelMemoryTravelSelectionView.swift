//
//  TravelMemorySelectionView.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit

class TravelMemoryTravelSelectionView: BaseView {
    
    // MARK: - properties
    let titleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, color: .black, font: .oaGothic(size: 18, weight: .heavy), text: "추억 남기기")
    }
    
    let exitButtonView = UIButton().then {
        $0.configureView(color: .gray70)
        $0.configureButton(fontColor: .white, font: .pretendard(size: 12, weight: .bold), text: "x")
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
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
