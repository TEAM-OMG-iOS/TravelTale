//
//  DiscoveryRegionViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/11/24.
//

import UIKit

final class DiscoveryRegionViewController: BaseViewController {
    
    // MARK: - properties
    private let discoveryRegionView = DiscoveryRegionView()

    // MARK: - life cycles
    override func loadView() {
        view = discoveryRegionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
//    // MARK: - methods
//    override func configureAddTarget() {
//        discoveryRegionView.cityButton.addTarget(self, action: #selector(tappedCityButton), for: .touchUpInside)
//        discoveryRegionView.districtButton.addTarget(self, action: #selector(tappedDistrictButton), for: .touchUpInside)
//        discoveryRegionView.submitButton.addTarget(self, action: #selector(tappedSubmitButton), for: .touchUpInside)
//    }
//    
//    @objc private func tappedCityButton
}
