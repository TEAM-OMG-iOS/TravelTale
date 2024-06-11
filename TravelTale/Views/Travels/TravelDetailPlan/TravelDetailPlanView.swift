//
//  TravelDetailPlanView.swift
//  TravelTale
//
//  Created by 김정호 on 6/8/24.
//

import UIKit

final class TravelDetailPlanView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView()
    
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
