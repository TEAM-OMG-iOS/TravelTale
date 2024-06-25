//
//  NotFoundView.swift
//  TravelTale
//
//  Created by 유림 on 6/26/24.
//

import UIKit

class NotFoundView: BaseView {
    
    // MARK: properties
    let notFoundStackView = UIStackView().then {
        $0.configureView(color: .white)
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    let notFoundImageView = UIImageView().then {
        $0.image = UIImage(named: "not_found_train")
        $0.contentMode = .scaleAspectFit
    }
    
    let notFoundLabel = UILabel().then {
        $0.configureLabel(color: .gray70,
                          font: .pretendard(size: 18, weight: .medium))
    }
    
    // MARK: methods
    override func configureHierarchy() {
        self.addSubview(notFoundStackView)
        
        [notFoundImageView,
         notFoundLabel].forEach{ notFoundStackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        notFoundStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY)
        }
        
        notFoundImageView.snp.makeConstraints {
            $0.width.equalTo(192)
            $0.height.equalTo(98)
        }
    }
    
    func setLabel(text: String) {
        notFoundLabel.text = text
    }
}
