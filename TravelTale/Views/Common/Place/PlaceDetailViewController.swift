//
//  PlaceDetailViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/18/24.
//

import MapKit
import UIKit

final class PlaceDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let placeDetailView = PlaceDetailView()
    
    // MARK: - life cycles
    override func loadView() {
        view = placeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureDelegate() {
        placeDetailView.imageCollectionView.dataSource = self
        placeDetailView.imageCollectionView.delegate = self
        
        placeDetailView.imageCollectionView.register(PlaceDetailImageCollectionViewCell.self, 
                                                     forCellWithReuseIdentifier: PlaceDetailImageCollectionViewCell().identifier)
    }
    
    override func configureAddTarget() {
        placeDetailView.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        placeDetailView.bookMarkButton.addTarget(self, action: #selector(tappedBookMarkButton), for: .touchUpInside)
        placeDetailView.copyAddressButton.addTarget(self, action: #selector(tappedCopyButton), for: .touchUpInside)
        placeDetailView.addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
    }
    
    @objc private func tappedBackButton() {
        print("tappedBackButton")
    }
    
    @objc private func tappedBookMarkButton() {
        print("tappedBookMarkButton")
    }
    
    @objc private func tappedCopyButton() {
        print("tappedCopyButton")
    }
    
    @objc private func tappedAddButton() {
        print("tappedAddButton")
    }
    
    func configurePageControl() {
        placeDetailView.pageController.backgroundStyle = .automatic
    }
}

// MARK: - extensions
extension PlaceDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension PlaceDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceDetailImageCollectionViewCell().identifier,
                                                      for: indexPath) as! PlaceDetailImageCollectionViewCell
        
        cell.bind(image: .splash)
        
        return cell
    }
}
