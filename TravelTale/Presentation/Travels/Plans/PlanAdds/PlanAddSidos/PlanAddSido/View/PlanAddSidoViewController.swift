//
//  PlanAddSidoViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class PlanAddSidoViewController: BaseViewController {
    
    // MARK: - properties
    private let planAddSidoView = PlanAddSidoView()
    
    var planTitle: String?
    var planSido: String?
    
    // MARK: - life cycles
    override func loadView() {
        view = planAddSidoView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        planAddSidoView.startLoadingAnimation()
    }

    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        planAddSidoView.placePickButton.addTarget(self, action: #selector(tappedInputBox), for: .touchUpInside)
        planAddSidoView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        planAddSidoView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        planAddSidoView.backButton.action = #selector(tappedBackButton)
        planAddSidoView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = planAddSidoView.backButton
    }
    
    @objc func tappedInputBox() {
        let locationList = PlanAddSidoModalViewController()
        locationList.configureSidoView()
        locationList.completion = { [weak self] sido in
            guard let self = self else { return }
            
            planAddSidoView.updatePlacePickButton(text: sido)
            self.planSido = sido.name
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedOkButton() {
        let nextVC = PlanAddDateViewController()
        nextVC.planTitle = planTitle
        nextVC.planSido = planSido
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
