//
//  TabBarViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - properties
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureBarAppearance()
    }
    
    // MARK: - methods
    private func configureViewControllers() {
        let travelViewController = TravelViewController()
        let discoveryViewController = DiscoveryViewController()
        let myPageViewController = MyPageViewController()
        
        let travelNavigation = UINavigationController(rootViewController: travelViewController)
        let discoveryNavigation = UINavigationController(rootViewController: discoveryViewController)
        let myPageNavigation = UINavigationController(rootViewController: myPageViewController)
        
        let viewControllers = [travelNavigation, discoveryNavigation, myPageNavigation]
        
        setViewControllers(viewControllers, animated: true)
        
        if let items = tabBar.items {
            items[0].title = "나의 여행"
            items[1].title = "둘러보기"
            items[2].title = "마이페이지"
            
            items[0].image = .myTravel
            items[1].image = .discovery
            items[2].image = UIImage(systemName: "person")
        }
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .green100
        tabBar.unselectedItemTintColor = .gray80
    }
    
    private func configureBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.font: UIFont.oaGothic(size: 18, weight: .heavy),
                                          .foregroundColor: UIColor.blueBlack100]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
