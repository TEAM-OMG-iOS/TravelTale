//
//  DiscoveryRegionModalViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/12/24.
//

import UIKit

final class DiscoveryRegionModalViewController: BaseViewController {
    
    // MARK: - properties
    private let discoveryRegionModalView = DiscoveryRegionModalView()
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryRegionModalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoveryRegionModalView.bind(selectString: "시/도 선택")
    }
}
