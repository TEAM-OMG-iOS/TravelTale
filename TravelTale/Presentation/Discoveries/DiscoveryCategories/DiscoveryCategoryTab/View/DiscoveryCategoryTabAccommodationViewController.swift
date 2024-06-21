//
//  DiscoveryCategoryTabAccommodationViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit
import XLPagerTabStrip

final class DiscoveryCategoryTabAccommodationViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryTabView = CategoryTabView()
    
    // MARK: - life cycles
    override func loadView() {
        view = categoryTabView
    }
    
    // MARK: - methods
    override func configureDelegate() {
        categoryTabView.tableView.dataSource = self
        categoryTabView.tableView.delegate = self
        
        categoryTabView.tableView.register(CategoryTabTableViewCell.self, forCellReuseIdentifier: CategoryTabTableViewCell.identifier)
    }
}

// MARK: - extensions
extension DiscoveryCategoryTabAccommodationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "숙박")
    }
}

extension DiscoveryCategoryTabAccommodationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - 데이터 바인딩
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as! CategoryTabTableViewCell
        
        // TODO: - 데이터 바인딩
        cell.selectionStyle = .none
        
        return cell
    }
}

extension DiscoveryCategoryTabAccommodationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailViewController()
        
        // TODO: - 데이터 바인딩
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}
