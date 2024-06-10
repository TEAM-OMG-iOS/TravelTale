//
//  TravelAddTitleViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddTitleViewController: BaseViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    let addTravelTitleView = TravelAddTitleView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = addTravelTitleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        customNavigationBar()
    }
    
    override func configureDelegate() {
        addTravelTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
        addTravelTitleView.textField.addTarget(self, action: #selector(tappedToRootView), for: .editingChanged)
        addTravelTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        addTravelTitleView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func bind() {
        
    }
    
    private func customNavigationBar() {
        let image = UIImage(systemName: "chevron.backward")
        let backButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tappedToRootView))
        backButtonItem.tintColor = .darkGray
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc func tappedOkButton() {
        let nextVC = TravelAddPlaceViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedToRootView() {
        addTravelTitleView.buttonColorChanged()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
