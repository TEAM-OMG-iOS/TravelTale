//
//  TravelAddCalendarViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class TravelAddCalendarViewController: BaseViewController {
    
    // MARK: - properties
    private let travelAddCalendarView = TravelAddCalendarView(monthsLayout: .vertical)
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddCalendarView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        travelAddCalendarView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelAddCalendarView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddCalendarView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddCalendarView.backButton.action = #selector(tappedBackButton)
        travelAddCalendarView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = travelAddCalendarView.backButton
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedOkButton() {
        self.navigationController?.popToRootViewController(animated: true)
        // TODO: 데이터 저장 상태로 RootView로 이동
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
