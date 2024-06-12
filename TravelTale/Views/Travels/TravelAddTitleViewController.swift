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
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddTitleView
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
        travelAddTitleView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
        travelAddTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddTitleView.backButton.action = #selector(tappedToRootView)
        travelAddTitleView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
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
