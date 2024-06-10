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
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
