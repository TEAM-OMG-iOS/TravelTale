//
//  PlanEditDateViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class PlanEditDateViewController: BaseViewController {
    
    // MARK: - properties
    let planEditDateView = PlanEditDateView(monthsLayout: .vertical)
    
    private let realmManager = RealmManager.shared
    
    // MARK: - lifecycl
    override func loadView() {
        view = planEditDateView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        planEditDateView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
    }
    
    @objc func tappedOkButton() {
        self.dismiss(animated: true)
    }
}
