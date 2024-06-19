//
//  BookMarkTotalViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

import XLPagerTabStrip

final class BookMarkTotalViewController: BaseViewController {
    
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
extension BookMarkTotalViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "전체")
    }
}

extension BookMarkTotalViewController: UITableViewDataSource {
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

extension BookMarkTotalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailViewController()
        
        // TODO: - 데이터 바인딩
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}

