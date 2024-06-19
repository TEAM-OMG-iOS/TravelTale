//
//  BookMarkEntertainmentViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

import XLPagerTabStrip

final class BookMarkEntertainmentViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryView = CategoryView()
    
    // MARK: - life cycles
    override func loadView() {
        view = categoryView
    }
    
    // MARK: - methods
    override func configureDelegate() {
        categoryView.tableView.dataSource = self
        categoryView.tableView.delegate = self
        
        categoryView.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
}

// MARK: - extensions
extension BookMarkEntertainmentViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "놀거리")
    }
}

extension BookMarkEntertainmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - 데이터 바인딩
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        // TODO: - 데이터 바인딩
        cell.selectionStyle = .none
        
        return cell
    }
}

// TODO: - tableView가 선택되었을 때, 상세 페이지로 이동하는 부분 구현
extension BookMarkEntertainmentViewController: UITableViewDelegate {
    
}

