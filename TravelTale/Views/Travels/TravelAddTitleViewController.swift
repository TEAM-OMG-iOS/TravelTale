//
//  TravelAddTitleViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddTitleViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let travelAddTitleView = TravelAddTitleView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = travelAddTitleView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        travelAddTitleView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
    }
    
    // MARK: - Methods
    
    override func configureStyle() { }
    
    override func configureDelegate() {
        travelAddTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
        travelAddTitleView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
        travelAddTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddTitleView.backButton.action = #selector(tappedToRootView)
        travelAddTitleView.backButton.target = self
    }
    
    override func bind() { }
    
    private func configureNavigationBarItems() {
        navigationItem.titleView = travelAddTitleView.pageTitleLabel
        self.navigationItem.leftBarButtonItem = travelAddTitleView.backButton
    }
    
    @objc func tappedOkButton() {
        let nextVC = TravelAddPlaceViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func changedButtonColor() {
        travelAddTitleView.buttonColorChanged()
    }
}
