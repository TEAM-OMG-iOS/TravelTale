//
//  MyPageBookMarkViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/16/24.
//

import UIKit

import XLPagerTabStrip

final class MyPageBookMarkViewController: ButtonBarPagerTabStripViewController {
    
    // MARK: - properties
    private let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let topBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    let bottomBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    var selectedIndexPath = 0
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHierarchy()
        configureConstraints()
        configureAddTarget()
        configureNavigationBar()
        
        DispatchQueue.main.async {
            self.moveToViewController(at: self.selectedIndexPath)
            self.reloadPagerTabStripView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        buttonBarView.backgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = .black
        buttonBarView.isScrollEnabled = false
        
        configureButtonBar()
    }
    
    private func configureHierarchy() {
        self.view.addSubview(topBorder)
        self.view.addSubview(bottomBorder)
    }
    
    private func configureConstraints() {
        buttonBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        topBorder.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(buttonBarView)
            $0.height.equalTo(1)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(buttonBarView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureAddTarget() {
        backButton.target = self
        backButton.action = #selector(tappedBackButton)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "북마크"
    }
    
    private func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .oaGothic(size: 15, weight: .medium)
        settings.style.buttonBarItemLeftRightMargin = 12
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                           newCell: ButtonBarViewCell?,
                                           progressPercentage: CGFloat,
                                           changeCurrentIndex: Bool,
                                           animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray70
            newCell?.label.textColor = .black
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let touristSpotVC = TouristSpotViewController()
        let restaurantVC = RestaurantViewController()
        let accommodationVC = AccommodationViewController()
        let entertainmentVC = EntertainmentViewController()
        
        return [touristSpotVC, restaurantVC, accommodationVC, entertainmentVC]
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
