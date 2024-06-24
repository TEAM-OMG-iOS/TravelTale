//
//  PlanAddDateViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class PlanAddDateViewController: BaseViewController {
    
    // MARK: - properties
    private let planAddDateView = PlanAddDateView(monthsLayout: .vertical)
    
    var planTitle: String?
    var planSido: String?
    
    // MARK: - lifecycle
    override func loadView() {
        view = planAddDateView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        planAddDateView.startLoadingAnimation()
    }

    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        planAddDateView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        planAddDateView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        planAddDateView.backButton.action = #selector(tappedBackButton)
        planAddDateView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = planAddDateView.backButton
    }
    
    @objc private func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func tappedOkButton() {
        RealmManager.shared.createTravel(title: planTitle ?? "제목을 입력주세요", area: planSido ?? "미정", startDate: planAddDateView.startDate ?? Date(), endDate: planAddDateView.endDate ?? Date())
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
