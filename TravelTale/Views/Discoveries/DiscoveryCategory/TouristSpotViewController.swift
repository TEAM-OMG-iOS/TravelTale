//
//  TouristSpotViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit

import XLPagerTabStrip

class TouristSpotViewController: BaseViewController {
    
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
extension TouristSpotViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "관광지")
    }
}

extension TouristSpotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - 데이터 바인딩
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        // TODO: - 데이터 바인딩
        cell.selectionStyle = .none
        
        return cell
    }
}

// TODO: - tableView가 선택되었을 때, 상세 페이지로 이동하는 부분 구현
extension TouristSpotViewController: UITableViewDelegate {
    
}
