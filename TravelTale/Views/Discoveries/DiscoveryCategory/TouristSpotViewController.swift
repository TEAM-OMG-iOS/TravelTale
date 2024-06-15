//
//  TouristSpotViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import XLPagerTabStrip

class TouristSpotViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - extensions
extension TouristSpotViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "관광지")
    }
}
