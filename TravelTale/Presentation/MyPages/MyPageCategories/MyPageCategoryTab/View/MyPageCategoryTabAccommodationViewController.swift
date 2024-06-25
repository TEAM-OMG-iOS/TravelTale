//
//  MyPageCategoryTabAccommodationViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit
import XLPagerTabStrip

final class MyPageCategoryTabAccommodationViewController: BaseViewController {
    
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
        bookmarkData = realmManager.fetchBookmarks(contentTypeId: .accommodation)
    }
}

// MARK: - extensions
extension MyPageCategoryTabAccommodationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "숙박")
    }
}

extension MyPageCategoryTabAccommodationViewController: UITableViewDataSource {
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

extension MyPageCategoryTabAccommodationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailViewController()
        
        networkManager.fetchPlaceDetail(contentId: bookmarkData[indexPath.row].contentId) { result in
            switch result {
            case .success(let placeDetails):
                placeDetailVC.placeDetailData = placeDetails.placeDetails ?? []
                placeDetailVC.loadView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}
