//
//  CategoryBar.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit

import XLPagerTabStrip

class CategoryBar: BaseView {
    
    // MARK: - properties
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
    }
    
    let cellId = "cellId"
    let imageNames = ["관광지", "음식점", "숙박", "놀거리"]
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAddTarget()
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    func configureAddTarget() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:[v0]", views: collectionView)
        addConstraintsWithFormat(format: "V:[v0]", views: collectionView)
    }
}

// MARK: - extensions
extension CategoryBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
}

extension CategoryBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.categoryTextLabel.text = imageNames[indexPath.item]
        cell.tintColor = .black
        
        return cell
    }
}

extension CategoryBar: UICollectionViewDelegateFlowLayout {
    
}
