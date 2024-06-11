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
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddPlaceView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        travelAddPlaceView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
    }
    
    // MARK: - methods
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() {
        travelAddPlaceView.placePickButton.addTarget(self, action: #selector(tappedInputBox), for: .touchUpInside)
        travelAddPlaceView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddPlaceView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddPlaceView.backButton.action = #selector(tappedToRootView)
        travelAddPlaceView.backButton.target = self
    }
    
    private func configureNavigationBarItems() {
        navigationItem.titleView = travelAddPlaceView.pageTitleLabel
        self.navigationItem.leftBarButtonItem = travelAddPlaceView.backButton
    }
    
    func updateInputBox(with text: String) {
        travelAddPlaceView.placePickButton.setTitle(text, for: .normal)
    }
    
    @objc func tappedInputBox() {
        let locationList = TravelAddLocationViewController()
        guard let sheet = locationList.sheetPresentationController else { return }
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            locationList.travelAddPlaceVC = self
            self.present(locationList, animated: true, completion: nil)
        }

    @objc func tappedOkButton() {
        let nextVC = TravelAddCalenderViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
