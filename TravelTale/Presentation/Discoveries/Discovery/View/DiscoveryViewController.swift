//
//  DiscoveryViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class DiscoveryViewController: BaseViewController {
    
    // MARK: - properties
    private let discoveryView = DiscoveryView()
    
    private let networkManager = NetworkManager.shared
    private let realmManager = RealmManager.shared
    private let userDefaultsManager = UserDefaultsManager.shared
    
    private let minimumLineSpacing: CGFloat = 16
    
    private var placeDatas: [Place] = []
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlaceDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
        discoveryView.setRegionLabel()
    }
    
    override func configureDelegate() {
        discoveryView.collectionView.delegate = self
        discoveryView.collectionView.dataSource = self
        discoveryView.collectionView.register(DiscoveryCollectionViewCell.self, forCellWithReuseIdentifier: DiscoveryCollectionViewCell.identifier)
    }
    
    override func configureAddTarget() {
        discoveryView.regionLabelButton.addTarget(self, action: #selector(tappedRegionButton), for: .touchUpInside)
        discoveryView.regionButton.addTarget(self, action: #selector(tappedRegionButton), for: .touchUpInside)
        
        discoveryView.searchButton.target = self
        discoveryView.searchButton.action = #selector(tappedSearchButton)
        
        [discoveryView.touristSpotButton,
         discoveryView.accommodationButton,
         discoveryView.restaurantButton,
         discoveryView.entertainmentButton].forEach { $0.addTarget(self, action: #selector(tappedCategoryButton(_:)), for: .touchUpInside) }
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = discoveryView.regionBarItem
        navigationItem.rightBarButtonItem = discoveryView.searchButton
    }
    
    @objc private func tappedRegionButton() {
        let discoveryRegionVC = DiscoveryRegionViewController()
        
        discoveryRegionVC.setRegionLabels()
        
        discoveryRegionVC.completion = {
            self.discoveryView.setRegionLabel()
            self.fetchPlaceDatas()
        }
        
        self.navigationController?.pushViewController(discoveryRegionVC, animated: true)
    }
    
    @objc private func tappedSearchButton() {
        let searchVC = SearchViewController()
        
        userDefaultsManager.setTabType(type: .discovery)
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc private func tappedCategoryButton(_ sender: UIButton) {
        let discoveryCategoryVC = DiscoveryCategoryViewController()
        let categoryArray = ["관광지", "음식점", "숙박", "놀거리"]
        
        discoveryCategoryVC.navigationItem.title = categoryArray[sender.tag]
        discoveryCategoryVC.selectedIndexPath = sender.tag
        
        self.navigationController?.pushViewController(discoveryCategoryVC, animated: true)
    }
    
    private func fetchPlaceDatas() {
        var sidoCode = "", sigunguCode = ""
        
        if let region = realmManager.fetchRegion() {
            sidoCode = region.sidoCode
            sigunguCode = region.sigunguCode ?? ""
        }
        
        networkManager.fetchPlaces(sidoCode: sidoCode, sigunguCode: sigunguCode, type: .total, page: 1) { [weak self] result in
            switch result {
            case .success(let places):
                self?.placeDatas = places.places ?? []
                
                DispatchQueue.main.async {
                    self?.discoveryView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - extensions
extension DiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeDetailDiscoveryVC = PlaceDetailDiscoveryViewController()
        
        guard let id = placeDatas[indexPath.row].contentId else { return }
        
        placeDetailDiscoveryVC.placeId = id
        
        self.navigationController?.pushViewController(placeDetailDiscoveryVC, animated: true)
    }
}

extension DiscoveryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, placeDatas.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoveryCollectionViewCell.identifier, for: indexPath) as? DiscoveryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(place: placeDatas[indexPath.row])
        
        return cell
    }
}

extension DiscoveryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - minimumLineSpacing - 40) / 2
        
        return CGSize(width: width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
}
