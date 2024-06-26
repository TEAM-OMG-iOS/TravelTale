//
//  MyPageCategoryTabTouristSpotViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit
import XLPagerTabStrip

final class MyPageCategoryTabTouristSpotViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryTabView = CategoryTabView()
    
    private let realmManager = RealmManager.shared
    private let networkManager = NetworkManager.shared
    
    private var bookmarkData: [Bookmark] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = categoryTabView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategoryTab()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        categoryTabView.tableView.dataSource = self
        categoryTabView.tableView.delegate = self
        
        categoryTabView.tableView.register(CategoryTabTableViewCell.self, forCellReuseIdentifier: CategoryTabTableViewCell.identifier)
    }
    
    private func fetchCategoryTab() {
        bookmarkData = realmManager.fetchBookmarks(contentTypeId: .tourist)
    }
}

// MARK: - extensions
extension MyPageCategoryTabTouristSpotViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "관광지")
    }
}

extension MyPageCategoryTabTouristSpotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as! CategoryTabTableViewCell
        
        cell.bind(bookMark: bookmarkData[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MyPageCategoryTabTouristSpotViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailDiscoveryViewController()
        
        placeDetailVC.placeId = bookmarkData[indexPath.row].contentId
        
        placeDetailVC.completion = {
            self.fetchCategoryTab()
            self.categoryTabView.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}

