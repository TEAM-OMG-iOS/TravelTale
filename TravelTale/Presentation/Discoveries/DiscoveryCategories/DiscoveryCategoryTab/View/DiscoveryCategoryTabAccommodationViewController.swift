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
    override func configureDelegate() {
        categoryTabView.tableView.dataSource = self
        categoryTabView.tableView.delegate = self
        
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
        
        networkManager.fetchPlaces(sidoCode: sidoCode, sigunguCode: sigunguCode, type: .accommodation, page: pageCount) { result in
            self.isLoading = false
            
            switch result {
            case .success(let place):
                let newPlaces = place.places ?? []
                
                if newPlaces.isEmpty {
                    self.hasMoreData = false
                } else {
                    self.placeData.append(contentsOf: newPlaces)
                    self.pageCount += 1
                    
                    DispatchQueue.main.async {
                        self.categoryTabView.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTabTableViewCell.identifier, for: indexPath) as! CategoryTabTableViewCell
        
        cell.selectionStyle = .none
        
        cell.bind(place: placeData[indexPath.row])
        
        return cell
    }
}

extension DiscoveryCategoryTabAccommodationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeDetailVC = PlaceDetailViewController()
        
        guard let id = placeData[indexPath.row].contentId else { return }
        
        networkManager.fetchPlaceDetail(contentId: id) { result in
            switch result {
            case .success(let placeDetail):
                placeDetailVC.placeDetailData = placeDetail.placeDetails
                
                DispatchQueue.main.async {
                    placeDetailVC.loadView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        placeDetailVC.completion = {
            self.categoryTabView.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(placeDetailVC, animated: true)
    }
}

extension DiscoveryCategoryTabAccommodationViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let shouldFetchMore = indexPaths.contains { $0.row >= placeData.count - 1 }
        if shouldFetchMore {
            fetchPlaceData()
        }
    }
}
