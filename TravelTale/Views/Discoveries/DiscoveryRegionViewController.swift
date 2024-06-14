//
//  DiscoveryRegionViewController.swift
//  TravelTale
//
//  Created by 배지해 on 6/11/24.
//

import UIKit

final class DiscoveryRegionViewController: BaseViewController {
    
    // MARK: - properties
    private let discoveryRegionView = DiscoveryRegionView()
    
    private var selectedCity = "" {
        didSet {
            updateSubmitButtonState()
        }
    }
    
    private var selectedDistrict = "" {
        didSet {
            updateSubmitButtonState()
        }
    }
    
    var completion: ((String) -> Void)?
    
    // MARK: - life cycles
    override func loadView() {
        view = discoveryRegionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureAddTarget() {
        discoveryRegionView.backButton.target = self
        discoveryRegionView.backButton.action = #selector(tappedBackButton)
        discoveryRegionView.cityButton.addTarget(self, action: #selector(tappedCityButton), for: .touchUpInside)
        discoveryRegionView.districtButton.addTarget(self, action: #selector(tappedDistrictButton), for: .touchUpInside)
        discoveryRegionView.submitButton.addTarget(self, action: #selector(tappedSubmitButton), for: .touchUpInside)
    }
    
    @objc private func tappedCityButton() {
        let discoveryRegionModalVC = DiscoveryRegionModalViewController()
        
        guard let sheet = discoveryRegionModalVC.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        
        discoveryRegionModalVC.bind(isCity: true)
        discoveryRegionModalVC.completion = { [weak self] text in
            guard let self = self else { return }
            self.selectedCity = text
            discoveryRegionView.selectCity(cityName: self.selectedCity)
        }
        
        self.present(discoveryRegionModalVC, animated: true)
    }
    
    @objc private func tappedDistrictButton() {
        let discoveryRegionModalVC = DiscoveryRegionModalViewController()
        
        guard let sheet = discoveryRegionModalVC.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        
        discoveryRegionModalVC.bind(isCity: false, city: selectedCity)
        discoveryRegionModalVC.completion = { [weak self] text in
            guard let self = self else { return }
            self.selectedDistrict = text
            discoveryRegionView.selectDistrict(districtName: self.selectedDistrict)
        }
        
        self.present(discoveryRegionModalVC, animated: true)
    }
    
    @objc private func tappedSubmitButton() {
        completion?("\(selectedCity) \(selectedDistrict)")
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "지역 설정"
        navigationItem.leftBarButtonItem = discoveryRegionView.backButton
    }
    
    private func updateSubmitButtonState() {
        discoveryRegionView.updateSubmitButtonState(city: selectedCity, district: selectedDistrict)
    }
    
    func setRegionLabels(region: String) {
        let regionArray = region.components(separatedBy: " ")
        discoveryRegionView.setCityAndDistrictLabels(cityName: regionArray[0], districtName: regionArray[1])
    }
}
