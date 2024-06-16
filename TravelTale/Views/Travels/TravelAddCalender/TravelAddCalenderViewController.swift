//
//  TravelAddCalenderViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

class TravelAddCalenderViewController: BaseViewController {
    
    // MARK: - properties
    private let travelAddCalenderView = TravelAddCalenderView(monthsLayout: .vertical)
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddCalenderView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        travelAddCalenderView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        travelAddCalenderView.okButton.isEnabled = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelAddCalenderView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddCalenderView.okButton.addTarget(self, action: #selector(popToRootView), for: .touchUpInside)
        travelAddCalenderView.backButton.action = #selector(popToRootView)
        travelAddCalenderView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = travelAddCalenderView.backButton
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func popToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
