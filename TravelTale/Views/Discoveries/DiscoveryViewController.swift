//
//  DiscoveryViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class DiscoveryViewController: UIViewController {

    // MARK: - properties
    private let discoveryView = DiscoveryView()
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
