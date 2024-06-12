//
//  TravelAddLocationView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class TravelAddLocationView: BaseView {
    
    // MARK: - properties
    private let guideLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold),
                          text: "대표 여행 장소를 선택해주세요")
    }
    
    let tableView = UITableView()
    
    // MARK: - methods
    override func configureHierarchy() {
        [guideLabel,
         tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
