//
//  BaseCollectionViewCell.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit
import SnapKit
import Then

class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureUI() { }
    
    func configureHierarchy() { }
    
    func configureConstraints() { }
}
