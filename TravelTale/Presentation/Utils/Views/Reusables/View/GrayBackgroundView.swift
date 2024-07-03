//
//  GrayBackgroundView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit
import SnapKit

final class GrayBackgroundView: BaseView {

    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        self.configureView(color: .gray5, cornerRadius: 20)
    }
    
    override func configureConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }
}
