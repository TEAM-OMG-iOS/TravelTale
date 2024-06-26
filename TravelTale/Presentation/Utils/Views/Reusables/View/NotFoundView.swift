//
//  NotFoundView.swift
//  TravelTale
//
//  Created by 유림 on 6/26/24.
//

import UIKit

final class NotFoundView: BaseView {
    
    // MARK: - properties
    private let stackView = UIStackView().then {
        $0.configureView(color: .white)
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "not_found_train")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = UILabel().then {
        $0.configureLabel(alignment: .center,
                          color: .gray70,
                          font: .pretendard(size: 18, weight: .medium),
                          numberOfLines: 0)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(stackView)
        
        [imageView,
         label].forEach{ stackView.addArrangedSubview($0) }
    }
    
    override func configureConstraints() {
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(self.snp.centerY).offset(-20)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(105)
        }
        
        label.snp.makeConstraints {
            $0.width.equalTo(250)
        }
    }
    
    func setLabel(text: String) {
        label.text = text
    }
}
