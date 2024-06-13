//
//  MyPageView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class MyPageView: BaseView {
    
    // MARK: - properties
//    let mypageLabel = UIBarItem().then {
//        $0.setTitleTextAttributes([ .font: UIFont.oaGothic(size: 20, weight: .heavy) ], for: .normal)
//        $0.title = "마이페이지"
//    }
    
    private let bookMarkBackgroundView = UIView().then {
        $0.configureView(color: .green10)
    }
    
    private let bookMarkLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "북마크")
    }
    
    let totalButton = UIButton().then {
        $0.configureButton(fontColor: .black, font: .pretendard(size: 14, weight: .regular), text: "전체보기")
    }
    
    private let buttonTopStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private let buttonBottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    let toristSpotBookMarkButton = BookMarkButton().then {
        $0.text = "관광지"
        $0.bookMarkImage = .touristSpotCircle
    }
    
    let restaurantBookMarkButton = BookMarkButton().then {
        $0.text = "음식점"
        $0.bookMarkImage = .restaurantCircle
    }
    
    let accommodationBookMarkButton = BookMarkButton().then {
        $0.text = "숙박"
        $0.bookMarkImage = .accommodationCircle
    }
    
    let entertainmentBookMarkButton = BookMarkButton().then {
        $0.text = "놀거리"
        $0.bookMarkImage = .entertainmentCircle
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        self.addSubview(bookMarkBackgroundView)
        bookMarkBackgroundView.addSubview(bookMarkLabel)
        bookMarkBackgroundView.addSubview(totalButton)
        bookMarkBackgroundView.addSubview(buttonTopStackView)
        bookMarkBackgroundView.addSubview(buttonBottomStackView)
        buttonTopStackView.addArrangedSubview(toristSpotBookMarkButton)
        buttonTopStackView.addArrangedSubview(restaurantBookMarkButton)
        buttonBottomStackView.addArrangedSubview(accommodationBookMarkButton)
        buttonBottomStackView.addArrangedSubview(entertainmentBookMarkButton)
    }
    
    override func configureConstraints() {
        bookMarkBackgroundView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        bookMarkLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
        
        totalButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(bookMarkLabel)
        }
        
        buttonTopStackView.snp.makeConstraints {
            $0.top.equalTo(bookMarkLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        buttonBottomStackView.snp.makeConstraints {
            $0.top.equalTo(buttonTopStackView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
