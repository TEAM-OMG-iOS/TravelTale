//
//  MyPageView.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class MyPageView: BaseView {
    
    // MARK: - properties
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = false
        $0.isDirectionalLockEnabled = true
    }
    
    private let contentView = UIView()
    
    private let myPageLabel = UILabel().then {
        $0.configureLabel(font: .oaGothic(size: 20, weight: .heavy), text: "마이페이지")
    }
    
    private let containverView = UIView()
    
    lazy var myPageBarItem = UIBarButtonItem(customView: containverView)
    
    private let bookMarkBackgroundView = UIView().then {
        $0.configureView(color: .green10)
    }
    
    private let bookMarkLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .bold), text: "북마크")
    }
    
    let totalButton = UIButton().then {
        $0.configureButton(font: .pretendard(size: 14, weight: .regular), text: "전체보기")
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
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.isScrollEnabled = false
        $0.sectionHeaderHeight = 56
        $0.sectionFooterHeight = 24
        $0.rowHeight = 48
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        containverView.addSubview(myPageLabel)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(containverView)
        contentView.addSubview(bookMarkBackgroundView)
        
        bookMarkBackgroundView.addSubview(bookMarkLabel)
        bookMarkBackgroundView.addSubview(totalButton)
        bookMarkBackgroundView.addSubview(buttonTopStackView)
        bookMarkBackgroundView.addSubview(buttonBottomStackView)
        
        buttonTopStackView.addArrangedSubview(toristSpotBookMarkButton)
        buttonTopStackView.addArrangedSubview(restaurantBookMarkButton)
        
        buttonBottomStackView.addArrangedSubview(accommodationBookMarkButton)
        buttonBottomStackView.addArrangedSubview(entertainmentBookMarkButton)
        
        contentView.addSubview(tableView)
    }
    
    override func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
    
        myPageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        
        bookMarkBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.horizontalEdges.equalToSuperview()
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(bookMarkBackgroundView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(tableView.sectionHeaderHeight * 2 + tableView.sectionFooterHeight * 2 + tableView.rowHeight * 4)
        }
    }
}
