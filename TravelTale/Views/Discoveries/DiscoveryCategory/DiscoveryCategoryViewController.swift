//
//  DiscoveryCategoryViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import UIKit
import XLPagerTabStrip

final class DiscoveryCategoryViewController: ButtonBarPagerTabStripViewController {
    
    // MARK: - properties
    private let topBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray70
    }
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    // MARK: - methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureUI() {
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
    }
    
    private func configureButtonBar() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemFont = .oaGothic(size: 15, weight: .medium)
        settings.style.buttonBarItemLeftRightMargin = 20
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        changeCurrentIndexProgressive = { [unowned self] (oldCell: ButtonBarViewCell?,
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
}
