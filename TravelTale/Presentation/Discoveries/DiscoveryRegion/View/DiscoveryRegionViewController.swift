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
    
    private var selectedSido: Sido? {
        didSet {
            updateSubmitButtonState()
        }
    }
    
    private var selectedSigungu: Sigungu? {
        didSet {
            updateSubmitButtonState()
        }
    }
    
    var completion: ((Sido?, Sigungu?) -> Void)?
    
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
        discoveryRegionView.sidoButton.addTarget(self, action: #selector(tappedSidoButton), for: .touchUpInside)
        discoveryRegionView.sigunguButton.addTarget(self, action: #selector(tappedSigunguButton), for: .touchUpInside)
        discoveryRegionView.submitButton.addTarget(self, action: #selector(tappedSubmitButton), for: .touchUpInside)
    }
    
    @objc private func tappedSidoButton() {
        let discoveryRegionModalSidoVC = DiscoveryRegionModalSidoViewController()
    
        discoveryRegionModalSidoVC.configureSidoView()
        discoveryRegionModalSidoVC.completion = { [weak self] sido in
            guard let self = self else { return }
            
            self.selectedSigungu = nil
            self.selectedSido = sido
            self.discoveryRegionView.selectSido(sidoName: sido.name ?? "")
        }
        
        self.present(discoveryRegionModalSidoVC, animated: true)
    }
    
    @objc private func tappedSigunguButton() {
        let discoveryRegionModalSigunguVC = DiscoveryRegionModalSigunguViewController()
        
        discoveryRegionModalSigunguVC.setSidoCode(sidoCode: selectedSido?.code ?? "")
        discoveryRegionModalSigunguVC.configureSigunguView()
        discoveryRegionModalSigunguVC.completion = { [weak self] sigungu in
            guard let self = self else { return }
            
            self.selectedSigungu = sigungu
            self.discoveryRegionView.selectSigungu(sigunguName: sigungu.name ?? "")
        }
        
        self.present(discoveryRegionModalSigunguVC, animated: true)
    }
    
    @objc private func tappedSubmitButton() {
        completion?(selectedSido ?? nil, selectedSigungu ?? nil)
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
        discoveryRegionView.updateSubmitButtonState(sido: selectedSido?.name ?? nil,
                                                    sigungu: selectedSigungu?.name ?? nil)
    }
    
    func setRegionLabels(region: String) {
        if region == DiscoveryView.regionDefaultText {
            discoveryRegionView.setSidoAndSigunguLabel(sidoText: "시/도를 선택해주세요.", sigunguText: "")
        }else {
            let regionArray = region.components(separatedBy: " ")
            discoveryRegionView.setSidoAndSigunguLabel(sidoText: regionArray[0], sigunguText: regionArray[1])
        }
    }
}
