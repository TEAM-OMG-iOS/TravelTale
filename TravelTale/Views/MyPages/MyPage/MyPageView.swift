//
//  MyPageView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class MyPageView: BaseView {
    
    // MARK: - properties
    let mypageLabel = UIBarItem().then {
        $0.setTitleTextAttributes([ .font: UIFont.oaGothic(size: 20, weight: .heavy) ], for: .normal)
        $0.title = "마이페이지"
    }
    
    private let bookMarkBackgroundView = UIView().then {
        $0.configureView( color: .green10)
    }
    
    private let bookMarkLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "북마크")
    }
    
    // MARK: - life cycles
    override func configureHierarchy() {
        self.addSubview(bookMarkBackgroundView)
        self.addSubview(bookMarkLabel)
    }
    
    override func configureConstraints() {
        bookMarkBackgroundView.snp.makeConstraints {
            $0.verticalEdges.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4143192488)
        }
        
        bookMarkLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
    }
}
