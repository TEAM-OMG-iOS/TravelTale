//
//  RestaurantViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import XLPagerTabStrip

class RestaurantViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - extensions
extension RestaurantViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "음식점")
    }
}
