//
//  TravelPlanDetailsViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/7/24.
//

import UIKit

final class TravelPlanDetailsViewController: BaseViewController {
    
    // MARK: - properties
    private let travelPlanDetailsView = TravelPlanDetailsView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelPlanDetailsView
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
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureAddTarget() {
        travelPlanDetailsView.backButton.target = self
        travelPlanDetailsView.backButton.action = #selector(tappedBackButton)
        
        travelPlanDetailsView.settingButton.target = self
        travelPlanDetailsView.settingButton.action = #selector(tappedSettingButton)
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = travelPlanDetailsView.backButton
        navigationItem.rightBarButtonItem = travelPlanDetailsView.settingButton
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func tappedSettingButton() {
        
    }
}
