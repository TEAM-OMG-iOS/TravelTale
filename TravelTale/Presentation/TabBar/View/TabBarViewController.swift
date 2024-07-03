//
//  TabBarViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureTabBarUI()
        configureNavigationBarAppearance()
    }
    
    // MARK: - methods
    private func configureViewControllers() {
        let travelNavigation = UINavigationController(rootViewController: TravelViewController())
        let discoveryNavigation = UINavigationController(rootViewController: DiscoveryViewController())
        let myPageNavigation = UINavigationController(rootViewController: MyPageViewController())
        
        let viewControllers = [travelNavigation, discoveryNavigation, myPageNavigation]
        
        setViewControllers(viewControllers, animated: true)
    }
    
    private func configureTabBarUI() {
        if let items = tabBar.items {
            items[0].title = "나의 여행"
            items[1].title = "둘러보기"
            items[2].title = "마이페이지"
            
            items[0].image = .myTravel
            items[2].image = UIImage(systemName: "person")
        }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // selected state
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.green100
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = .green100
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        // normal state
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray80
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray80
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        configureBorderLine()
        configureMiddleButton()
    }
    
    private func configureBorderLine() {
        let borderLine = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.view.bounds.width,
                                              height: 1)).then {
            $0.configureView(color: .gray20)
        }
        
        self.tabBar.addSubview(borderLine)
    }
    
    private func configureMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 25,
                                                  y: -20,
                                                  width: 50,
                                                  height: 50)) .then {
            $0.setImage(.discovery, for: .normal)
            $0.backgroundColor = .green100
            $0.tintColor = .white
            $0.layer.cornerRadius = ($0.layer.frame.width / 2)
        }
        
        self.tabBar.addSubview(middleButton)
        
        middleButton.addTarget(self, action: #selector(tappedMiddleButton), for: .touchUpInside)
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.font: UIFont.oaGothic(size: 18, weight: .heavy),
                                          .foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // MARK: - objc functions
    @objc func tappedMiddleButton(sender: UIButton) {
        self.selectedIndex = 1
    }
}
