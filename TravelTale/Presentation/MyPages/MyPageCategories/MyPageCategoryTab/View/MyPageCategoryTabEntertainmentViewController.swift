//
//  MyPageCategoryTabEntertainmentViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit
import XLPagerTabStrip

final class MyPageCategoryTabEntertainmentViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryTabView = CategoryTabView()
    
    private let realmManager = RealmManager.shared
    private let networkManager = NetworkManager.shared
    
    private var bookmarkData: [Bookmark] = [] {
        didSet {
            categoryTabView.showNotFoundView(bookmarkData.isEmpty)
            categoryTabView.tableView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = categoryTabView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategoryTab()
    }
    
    // MARK: - methods
    override func configureStyle() {
        categoryTabView.setNotFoundViewText(text: """
등록된 북마크가 없습니다.
가고 싶은 장소를 등록해 보세요.
""")
    }
    
    override func configureDelegate() {
        categoryTabView.tableView.dataSource = self
        categoryTabView.tableView.delegate = self
        
        categoryTabView.tableView.register(CategoryTabTableViewCell.self, forCellReuseIdentifier: CategoryTabTableViewCell.identifier)
    }
    
    private func fetchCategoryTab() {
        bookmarkData = realmManager.fetchBookmarks(contentTypeId: .entertainment)
    }
}

// MARK: - extensions
extension MyPageCategoryTabEntertainmentViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "놀거리")
    }
}

extension MyPageCategoryTabEntertainmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - 데이터 바인딩
        return bookmarkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as! CategoryTabTableViewCell
        
        cell.bind(bookMark: bookmarkData[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MyPageCategoryTabEntertainmentViewController: UITableViewDelegate {
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

