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
    }
    
    override func configureDelegate() {
        addTravelTitleView.textField.delegate = self
    }
    
    override func configureAddTarget() {
    }
    
    override func bind() {
        
    }
}
