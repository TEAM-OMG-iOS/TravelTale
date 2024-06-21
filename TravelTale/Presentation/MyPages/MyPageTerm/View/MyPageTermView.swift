//
//  MyPageTermView.swift
//  TravelTale
//
//  Created by 배지해 on 6/20/24.
//

import UIKit

final class MyPageTermView: BaseView {
    
    // MARK: - properties
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let textView = UITextView().then {
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.isEditable = false
        $0.textColor = .black
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(textView)
    }
    
    override func configureConstraints() {
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
    }
    
    func setText(text: String) {
        textView.text = text
    }
}
