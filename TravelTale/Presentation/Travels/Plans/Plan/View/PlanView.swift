//
//  TravelPlanView.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

final class PlanView: BaseView {
    
    // MARK: - properties
    let addButtonView = LightGreenButton()
    let tableView = UITableView()
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        addButtonView.configureButton(text: "새 여행 추가")
    }
    
    override func configureHierarchy() {
        [addButtonView,
         tableView].forEach { self.addSubview($0) }
    }
    
    override func configureConstraints() {
        
        let horizontalInset = 24
        
        addButtonView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(addButtonView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(horizontalInset)
            $0.bottom.equalToSuperview()
        }
    }
}
