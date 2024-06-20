//
//  CustomPopUpView.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class CustomPopUpView: BaseView {
    
    // MARK: - properties
    private let backgroundView = UIView().then {
        $0.configureView(color: .black, clipsToBounds: true, cornerRadius: 10)
        $0.isOpaque = false
        $0.alpha = 0.8
    }

    private let label = UILabel().then {
        $0.configureLabel(color: .white, font: .pretendard(size: 16, weight: .medium))
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(label)
    }
    
    override func configureConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    func setText(text: String) {
        label.text = "\(text)가 복사되었습니다."
    }
}
