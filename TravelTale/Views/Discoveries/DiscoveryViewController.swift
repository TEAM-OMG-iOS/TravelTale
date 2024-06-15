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
    private let minimumLineSpacing: CGFloat = 16
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        discoveryView.collectionView.delegate = self
        discoveryView.collectionView.dataSource = self
        discoveryView.collectionView.register(DiscoveryCell.self, forCellWithReuseIdentifier: DiscoveryCell.identifier)
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
        
        if let region = discoveryView.regionLabelButton.titleLabel?.text {
            discoveryRegionVC.setRegionLabels(region: region)
        }
        
        discoveryRegionVC.completion = { [weak self] text in
            guard let self = self else { return }
            discoveryView.bind(region: text)
        }
        
        self.navigationController?.pushViewController(discoveryRegionVC, animated: true)
    }
    
    @objc private func tappedSearchButton() {
        // todo : 검색 창 Navi로 띄우기
    }
    
    @objc private func tappedCategoryButton(_ sender: UIButton) {
        let discoveryCategoryVC = DiscoveryCategoryViewController()
        
        guard let category = sender.titleLabel else { return }
        discoveryCategoryVC.navigationItem.title = category.text
        
        self.navigationController?.pushViewController(discoveryCategoryVC, animated: true)
    }
}

// MARK: - extension
extension DiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // todo : 디테일 VC로 이동
    }
}

extension DiscoveryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoveryCell.identifier,
                                                            for: indexPath) as? DiscoveryCell else {
            return UICollectionViewCell()
        }
        
        // Todo : 데이터에서 가져온 값 넣어야 함.
        cell.bind(placeImage: nil,
                  place: "석촌호수 공원 안녕하세요 여기는 저희 집 입니다.ㅎㅎㅎㅎㅎㅎㅎㅎ",
                  placeAddress: "테헤란로 412 우주 끝까지 달려나가자~~~~!!!!!!!!!!!!!!!")
        
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
