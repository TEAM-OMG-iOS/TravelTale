//
//  SearchView.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit

final class SearchView: BaseView {
    
    // MARK: - properties
    let backBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    let titleLabel = UILabel().then {
        $0.configureLabel(alignment: .center, font: .oaGothic(size: 18, weight: .heavy), text: "검색")
    }
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.setImage(.search.resize(width: 28, height: 28), for: .search, state: .normal)
        $0.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.gray70).resize(width: 20, height: 20), for: .clear, state: .normal)
    }
    
    private let recentSearchLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .semibold), text: "최근 검색어")
    }
    
    let deleteAllButton = UIButton().then {
        $0.configureButton(fontColor: .black.withAlphaComponent(0.3), font: .pretendard(size: 12, weight: .semibold), text: "전체 삭제")
    }
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(recentSearchLabel)
        self.addSubview(deleteAllButton)
        self.addSubview(tableView)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.height.equalTo(40)
        }
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(12)
        }
        
        deleteAllButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        tableView.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(recentSearchLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
