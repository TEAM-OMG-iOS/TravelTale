//
//  MyPageViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    // MARK: - properties
    private let myPageView = MyPageView()
    
    // MARK: - life cycles
    override func loadView() {
        view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
         myPageView.restaurantBookMarkButton].forEach { $0.addTarget(self, action: #selector(tappedCategoryButton(_:)), for: .touchUpInside) }
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = myPageView.myPageBarItem
    }
    
    @objc private func tappedTotalButton() {
        let bookMarkVC = BookMarkViewController()
        
        bookMarkVC.selectedIndexPath = 0
        
        self.navigationController?.pushViewController(bookMarkVC, animated: true)
    }
    
    @objc private func tappedCategoryButton(_ sender: BookMarkButton) {
        print("tappedCategoryButton")
        let bookMarkVC = BookMarkViewController()
        let categoryArray = ["전체", "관광지", "음식점", "숙박", "놀거리"]
        
        print(sender.getButtonName())
        bookMarkVC.selectedIndexPath = categoryArray.firstIndex(of: sender.getButtonName()) ?? 1
        
        self.navigationController?.pushViewController(bookMarkVC, animated: true)
    }
}
