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
}
