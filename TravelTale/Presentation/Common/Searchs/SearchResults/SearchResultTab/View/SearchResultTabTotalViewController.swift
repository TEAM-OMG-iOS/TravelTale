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
    
    private let realmManager = RealmManager.shared
    private let networkManager = NetworkManager.shared
    
    private let tabType = UserDefaultsManager.shared.fetchTabType()
    private lazy var bookmarks = realmManager.fetchBookmarks(contentTypeId: .total)
    
    private var page = 1
    private var searchText: String
    private var isLoadingLast = false
    private var places: [PlaceSearch] = []
    
    // MARK: - life cycles
    init(searchText: String) {
        self.searchText = searchText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func bind() {
        switch tabType {
        case .travel:
            fetchSearchedPlacesByTravelTapType()
        case .discovery:
            fetchSearchedPlacesByDiscoveryTapType()
        }
    }
    
    private func fetchSearchedPlacesByTravelTapType() {
        networkManager.fetchSearchedPlaces(keyword: searchText,
                                           type: .total,
                                           page: page) { [weak self] result in
            self?.fetchResult(result: result)
        }
    }
    
    private func fetchSearchedPlacesByDiscoveryTapType() {
        if let region = realmManager.fetchRegion() {
            networkManager.fetchSearchedPlaces(sidoCode: region.sidoCode,
                                               sigunguCode: region.sigunguCode ?? "",
                                               keyword: searchText,
                                               type: .total,
                                               page: page) { [weak self] result in
                self?.fetchResult(result: result)
            }
        } else {
            fetchSearchedPlacesByTravelTapType()
        }
    }
    
    private func fetchResult(result: Result<PlaceSearchs, any Error>) {
        switch result {
        case .success(let data):
            places += data.placeSearchs ?? []
            searchResultTabView.tableView.reloadData()
        case .failure(_):
            isLoadingLast = true
        }
        
        searchResultTabView.bind(hasPlaces: !places.isEmpty)
    }
    
    func bindRefetchedPlaces(searchText: String) {
        self.searchText = searchText
        
        places = []
        isLoadingLast = false
        page = 1
        
        bind()
    }
    
    private func bindMorePlaces() {
        if isLoadingLast == true {
            return
        }
        
        page += 1
        
        bind()
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
        if tabType == .travel {
            let placeDetailTravelVC = PlaceDetailTravelViewController()
            placeDetailTravelVC.placeId = places[indexPath.row].contentId
            
            navigationController?.pushViewController(placeDetailTravelVC, animated: true)
        } else {
            let placeDetailDiscoveryVC = PlaceDetailDiscoveryViewController()
            placeDetailDiscoveryVC.placeId = places[indexPath.row].contentId
            
            navigationController?.pushViewController(placeDetailDiscoveryVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == places.count - 1 {
            bindMorePlaces()
        }
    }
}

extension SearchResultTabTotalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTabTableViewCell.identifier, for: indexPath) as? SearchResultTabTableViewCell else { return UITableViewCell() }
        
        let isBookmarked = bookmarks.map { $0.contentId }.contains(places[indexPath.row].contentId)
        
        cell.selectionStyle = .none
        cell.bind(place: places[indexPath.row], isBookmarked: isBookmarked)
        
        return cell
    }
}
