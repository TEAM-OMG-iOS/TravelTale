//
//  DiscoveryCategoryTabRestaurantViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit
import XLPagerTabStrip

final class DiscoveryCategoryTabRestaurantViewController: BaseViewController {
    
    // MARK: - properties
    private let categoryTabView = CategoryTabView()
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    
    private var placeData: [Place] = []
    
    private var pageCount = 1
    
    private var isLoading = false
    private var hasMoreData = true
    
    // MARK: - life cycles
    override func loadView() {
        view = categoryTabView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlaceData()
    }
    
    // MARK: - methods
    override func configureStyle() {
        categoryTabView.setRegionLabel()
        categoryTabView.setNotFoundViewText(text: "등록된 장소가 없습니다.")
    }
    
    override func configureDelegate() {
        categoryTabView.tableView.dataSource = self
        categoryTabView.tableView.delegate = self
        categoryTabView.tableView.prefetchDataSource = self
        
        categoryTabView.tableView.register(CategoryTabTableViewCell.self, forCellReuseIdentifier: CategoryTabTableViewCell.identifier)
    }
    
    private func fetchPlaceData() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        
        var sidoCode = "", sigunguCode = ""
        
        if let region = realmManager.fetchRegion() {
            sidoCode = region.sidoCode
            sigunguCode = region.sigunguCode ?? ""
        }
        
        networkManager.fetchPlaces(sidoCode: sidoCode, sigunguCode: sigunguCode, type: .restaurant, page: pageCount) { result in
            self.isLoading = false
            
            switch result {
            case .success(let place):
                let newPlaces = place.places ?? []
                
                if newPlaces.isEmpty {
                    self.configureNotFoundView()
                    self.hasMoreData = false
                } else {
                    self.placeData.append(contentsOf: newPlaces)
                    self.pageCount += 1
                    
                    DispatchQueue.main.async {
                        self.categoryTabView.tableView.reloadData()
                    }
                }
            case .failure(let error):
                self.configureNotFoundView()
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNotFoundView() {
        categoryTabView.showNotFoundView(placeData.isEmpty)
        categoryTabView.tableView.reloadData()
    }
}

// MARK: - extensions
extension DiscoveryCategoryTabRestaurantViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "음식점")
    }
}

extension DiscoveryCategoryTabRestaurantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as! CategoryTabTableViewCell
        
        cell.selectionStyle = .none
        
        cell.bind(place: placeData[indexPath.row])
        
        return cell
    }
}

extension DiscoveryCategoryTabRestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailDiscoveryViewController()
        
        guard let id = placeData[indexPath.row].contentId else { return }
        
        placeDetailVC.placeId = id
        
        placeDetailVC.completion = {
            self.categoryTabView.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}

extension DiscoveryCategoryTabRestaurantViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= placeData.count - 1 }) {
            fetchPlaceData()
        }
    }
}
