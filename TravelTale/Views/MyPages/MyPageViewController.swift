//
//  MyPageViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageView = MyPageView()
    
    // MARK: - life cycles
    override func loadView() {
        view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureAddTarget() {
        myPageView.totalButton.addTarget(self, action: #selector(tappedTotalButton), for: .touchUpInside)
        
        [myPageView.toristSpotBookMarkButton,
         myPageView.accommodationBookMarkButton,
         myPageView.entertainmentBookMarkButton,
         myPageView.restaurantBookMarkButton].forEach { $0.addTarget(self, action: #selector(tappedCategoryButton), for: .touchUpInside) }
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = myPageView.myPageBarItem
    }
    
    @objc private func tappedTotalButton() {
        // TODO : 카테고리 버튼 Navi로 띄우기
    }
    
    @objc private func tappedCategoryButton() {
        // TODO : 카테고리 버튼 Navi로 띄우기
    }
}
