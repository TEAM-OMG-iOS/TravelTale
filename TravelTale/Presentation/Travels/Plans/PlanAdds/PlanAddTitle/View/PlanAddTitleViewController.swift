//
//  PlanAddTitleViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class PlanAddTitleViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - properties
    private let planAddTitleView = PlanAddTitleView()
    
    // MARK: - life cycles
    override func loadView() {
        view = planAddTitleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        planAddTitleView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureDelegate() {
        planAddTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
        planAddTitleView.textField.addTarget(self, action: #selector(editiedTextField), for: .editingChanged)
        planAddTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        planAddTitleView.backButton.action = #selector(tappedBackButton)
        planAddTitleView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = planAddTitleView.backButton
    }
    
    @objc func tappedOkButton() {
        let nextVC = PlanAddSidoViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func editiedTextField() {
        planAddTitleView.buttonColorChanged()
    }
}
