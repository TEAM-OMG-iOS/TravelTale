//
//  CategoryTabView.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

final class CategoryTabView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView()
    
    let notFoundView = NotFoundView().then {
        $0.isHidden = true
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        tableView.separatorStyle = .none
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
        addSubview(notFoundView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        notFoundView.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
    }
    
    func setNotFoundViewText(text: String) {
        notFoundView.setLabel(text: text)
    }
    
    func showNotFoundView(_ isNotFound: Bool) {
        notFoundView.isHidden = !isNotFound
    }
}
