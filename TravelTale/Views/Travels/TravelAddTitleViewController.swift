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
        customNavigationBar()
    }
    
    // MARK: - Methods
    
    override func configureStyle() { }
    
    override func configureDelegate() {
        travelAddTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
        travelAddTitleView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
        travelAddTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddTitleView.backButtonItem.action = #selector(tappedToRootView)
        travelAddTitleView.backButtonItem.target = self
    }
    
    override func bind() { }
    
    private func customNavigationBar() {
        navigationItem.titleView = travelAddTitleView.pageTitleLabel
        self.navigationItem.leftBarButtonItem = travelAddTitleView.backButtonItem
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
