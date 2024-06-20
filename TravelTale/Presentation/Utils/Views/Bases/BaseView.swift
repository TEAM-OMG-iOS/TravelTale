//
//  BaseView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit
import SnapKit
import Then

protocol BaseViewProtocol {
    func configureUI()
    func configureHierarchy()
    func configureConstraints()
}

class BaseView: UIView, BaseViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .white
    }
    
    func configureHierarchy() { }
    
    func configureConstraints() { }
}
