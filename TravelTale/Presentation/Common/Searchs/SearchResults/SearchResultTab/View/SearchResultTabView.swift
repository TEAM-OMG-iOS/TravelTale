//
//  SearchResultTabView.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

final class SearchResultTabView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView()
    
    private let notFoundView = NotFoundView().then {
        $0.setLabel(text: "검색 결과가 존재하지 않습니다.")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(tableView)
        self.addSubview(notFoundView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        notFoundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind(hasPlaces: Bool) {
        if hasPlaces {
            tableView.isHidden = false
            notFoundView.isHidden = true
        }
    }
}
