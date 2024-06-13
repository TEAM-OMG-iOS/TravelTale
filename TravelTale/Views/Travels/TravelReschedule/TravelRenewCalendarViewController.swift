//
//  TravelRenewCalendarViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit

final class TravelRenewCalendarViewController: BaseViewController {
    
    // MARK: - properties
    private let travelRenewCalendarView = TravelRenewCalendarView()
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelRenewCalendarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {

    }
    
    override func bind() {
        
    }
}
