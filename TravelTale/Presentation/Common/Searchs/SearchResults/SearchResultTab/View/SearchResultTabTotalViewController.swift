//
//  SearchResultTabTotalViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/21/24.
//

import UIKit
import XLPagerTabStrip

final class SearchResultTabTotalViewController: BaseViewController {
    
    // MARK: - properties
    private let searchResultTabView = SearchResultTabView()
    
    // MARK: - life cycles
    override func loadView() {
        view = searchResultTabView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        searchResultTabView.tableView.delegate = self
        searchResultTabView.tableView.dataSource = self
        
        searchResultTabView.tableView.register(SearchResultTabTableViewCell.self, forCellReuseIdentifier: SearchResultTabTableViewCell.identifier)
    }
}

// MARK: - extensions
extension SearchResultTabTotalViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "전체")
    }
}

extension SearchResultTabTotalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailViewController = PlaceDetailViewController()
        
        navigationController?.pushViewController(placeDetailViewController, animated: true)
    }
}

extension SearchResultTabTotalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTabTableViewCell.identifier, for: indexPath) as? SearchResultTabTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
