//
//  AccommodationViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/15/24.
//

import XLPagerTabStrip

class AccommodationViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - extensions
extension AccommodationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "숙박")
    }
}
