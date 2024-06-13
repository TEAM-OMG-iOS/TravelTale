//
//  TravelAddCalenderViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class TravelAddCalenderViewController: BaseViewController {
    
    // MARK: - Properties
    
    let travelAddCalenderView = TravelAddCalenderView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = travelAddCalenderView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        travelAddCalenderView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {
        travelAddCalenderView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func bind() {
        
    }
    
    private func customNavigationBar() {
        let image = UIImage(systemName: "chevron.backward")
        let backButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tappedToRootView))
        backButtonItem.tintColor = .gray90
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
