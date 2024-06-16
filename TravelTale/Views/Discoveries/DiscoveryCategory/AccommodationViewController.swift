//
//  AccommodationViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit

import XLPagerTabStrip

class AccommodationViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryView = CategoryView()
    
    // 임시 데이터
    private let placeData: [PlaceData] = [PlaceData.init(), PlaceData.init(), PlaceData.init()]
    
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
extension AccommodationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "숙박")
    }
}

extension AccommodationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        let data = placeData[indexPath.row]
        cell.bind(placeImage: data.placeImage, place: data.place, placeAddress: data.placeAddress)
        cell.selectionStyle = .none
        
        return cell
    }
}

// TODO: - tableView가 선택되었을 때, 상세 페이지로 이동하는 부분 구현
extension AccommodationViewController: UITableViewDelegate {
    
}
