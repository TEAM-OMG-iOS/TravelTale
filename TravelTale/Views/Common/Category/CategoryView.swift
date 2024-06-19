//
//  CategoryView.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

final class CategoryView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView()
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        
        tableView.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
