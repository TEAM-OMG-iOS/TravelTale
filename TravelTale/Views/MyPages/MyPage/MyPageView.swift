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
}
