//
//  TravelAddTitleViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddTitleViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - properties
    private let travelAddTitleView = TravelAddTitleView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelAddTitleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelAddTitleView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureDelegate() {
        travelAddTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
        travelAddTitleView.textField.addTarget(self, action: #selector(editiedTextField), for: .editingChanged)
        travelAddTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddTitleView.backButton.action = #selector(tappedBackButton)
        travelAddTitleView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = travelAddTitleView.backButton
    }
    
    @objc func tappedOkButton() {
        let nextVC = TravelAddPlaceViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func editiedTextField() {
        travelAddTitleView.buttonColorChanged()
    }
}
