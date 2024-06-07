//
//  TravelAddButton.swift
//  TravelTale
//
//  Created by 유림 on 6/7/24.
//

import UIKit

class TravelAddView: BaseView {
    
    // MARK: - properties
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
    }
    
    private let circleView = UIView().then {
        $0.configureView(color: .green100, cornerRadius: 10)
    }
    
    private let plusImageView = UIImageView()
    
    private let label = UILabel().then {
        $0.configureLabel(color: .blueBlack100, font: .pretendard(size: 18, weight: .semibold))
    }
    
    let button = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    
    // MARK: - methods
    override func configureUI() {
        self.configureView(color: .green10, cornerRadius: 24)
        
        plusImageView.image = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
        plusImageView.tintColor = .blueBlack100
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
        
        circleView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        plusImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind(text: String) {
        label.text = text
    }
}

