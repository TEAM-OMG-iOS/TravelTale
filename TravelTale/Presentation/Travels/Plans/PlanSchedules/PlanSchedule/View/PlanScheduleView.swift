//
//  PlanScheduleView.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit

final class PlanScheduleView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView().then {
        $0.bounces = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
