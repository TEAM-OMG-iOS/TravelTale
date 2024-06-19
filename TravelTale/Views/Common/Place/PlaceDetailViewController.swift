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
    private var isBookMarked: Bool = false
    
    // MARK: - life cycles
    override func loadView() {
        view = placeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeDetailView.bind(placeName: "설빙 석촌호수 동호점",
                             placeCategory: "관광지",
                             placePhoneNumber: "053-565-7665",
                             placeWebSite: "www.naver.com",
                             placeDescription: "안녕하세요. 코코종입니다. 안녕하세요. 코코몽입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다. 안녕하세요. 코코종입니다.",
                             placeAddress: "서울 송파구 석촌호수로 278",
                             isBookMarked: true)
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
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedBookMarkButton() {
        if isBookMarked {
            placeDetailView.configureBookMarkButton(isBookMarked: false)
            isBookMarked = false
        }else {
            placeDetailView.configureBookMarkButton(isBookMarked: true)
            isBookMarked = true
        }
    }
    
    @objc private func tappedCopyButton() {
        print("tappedCopyButton")
    }
    
    @objc private func tappedAddButton() {
        print("tappedAddButton")
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
        
        cell.bind(image: .splashScale)
        
        return cell
    }
}
