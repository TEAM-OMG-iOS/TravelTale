//
//  TravelAddButton.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

class TravelAddView: BaseView {
    
    let stackView = UIStackView()
    let circleView = UIView()
    let plusImageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    
    // MARK: - Methods
    
    override func configureUI() {
        
        self.configureView(color: .green10, cornerRadius: 24)
        
        stackView.axis = .horizontal
        stackView.spacing = 12
        
        circleView.backgroundColor = .green100
        circleView.layer.cornerRadius = 10
        circleView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        plusImageView.image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
        plusImageView.tintColor = .blueBlack100
        
        label.textColor = .blueBlack100
        label.font = .pretendard(size: 18, weight: .semibold)
        
        button.backgroundColor = .clear
        
    }
    
    override func configureHierarchy() {
        
        [stackView,
         button].forEach { self.addSubview($0) }
        
        [circleView,
         label].forEach { stackView.addArrangedSubview($0) }
        
        circleView.addSubview(plusImageView)
    }
    
    
    override func configureConstraints() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        plusImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}

