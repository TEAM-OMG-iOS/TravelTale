//
//  GreenButton.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit
import SnapKit

final class GreenButton: UIButton {
    
    // MARK: - properties
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    func configureUI() {
        self.configureView(color: .green100, cornerRadius: 24)
        self.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .bold))
    }
    
    func configureConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(52)
        }
    }
}
