//
//  TermView.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class TermView: BaseView {
    
    // MARK: - properties
    private let textLabel = UITextView().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.isEditable = false
        $0.textColor = .black
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(textLabel)
    }
    
    override func configureConstraints() {
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
    }
}
