//
//  TravelAddPlaceViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddPlaceViewController: BaseViewController {
    
    // MARK: - properties
    private let travelAddPlaceView = TravelAddPlaceView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelAddPlaceView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        travelAddPlaceView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() { 
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelAddPlaceView.placePickButton.addTarget(self, action: #selector(tappedInputBox), for: .touchUpInside)
        travelAddPlaceView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddPlaceView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddPlaceView.backButton.action = #selector(tappedBackButton)
        travelAddPlaceView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = travelAddPlaceView.backButton
    }
    
    @objc func tappedInputBox() {
        let locationList = TravelAddPlaceModalViewController()
        locationList.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelAddPlaceView.updatePlacePickButton(text: text)
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedOkButton() {
        let nextVC = TravelAddCalendarViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
