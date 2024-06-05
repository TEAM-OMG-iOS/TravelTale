//
//  AddTravelTitleVC.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class AddTravelTitleVC: BaseViewController, UITextFieldDelegate {
    // MARK: - Properties
    let addTravelTitleView = AddTravelTitleView()
    
    override func loadView() {
        view = addTravelTitleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
    }
    
    override func configureStyle() {
        addTravelTitleView.okButton.isEnabled = false
    }
    
    override func configureDelegate() {
        addTravelTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() { 
        addTravelTitleView.textField.addTarget(self, action: #selector(buttonColorChanged), for: .editingChanged)
        addTravelTitleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        addTravelTitleView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func bind() { 
        
    }
    
    @objc func buttonColorChanged() {
        if addTravelTitleView.textField.text?.isEmpty != true {
            addTravelTitleView.okButton.isEnabled = true
            addTravelTitleView.okButton.backgroundColor = .green100
        } else {
            addTravelTitleView.okButton.isEnabled = false
            addTravelTitleView.okButton.backgroundColor = .green10
        }
    }
    
    @objc func tappedOkButton() {
        let nextVC = AddTravelPlaceVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func tappedCancelButton() {
//        let beforeVC =
//        self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
    }
}
