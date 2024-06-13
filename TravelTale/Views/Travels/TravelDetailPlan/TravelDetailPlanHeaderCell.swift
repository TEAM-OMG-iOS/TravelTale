//
//  TravelDetailPlanHeaderCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/11/24.
//

import UIKit

final class TravelDetailPlanHeaderCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: TravelDetailPlanHeaderCell.self)
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout()).then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.contentView.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-26)
            $0.height.equalTo(27)
        }
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemsSize = ("Day 0").size(withAttributes: [.font: UIFont.oaGothic(size: 15, weight: .heavy)]).width * 5
        let horizontalEdges: CGFloat = 20 * 2
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = ((UIScreen.main.bounds.width - horizontalEdges - itemsSize) / 4)
        layout.minimumInteritemSpacing = ((UIScreen.main.bounds.width - horizontalEdges - itemsSize) / 4)
        
        return layout
    }
}
