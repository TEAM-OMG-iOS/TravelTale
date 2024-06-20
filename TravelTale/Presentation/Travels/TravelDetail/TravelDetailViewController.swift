//
//  TravelDetailViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/7/24.
//

import UIKit
import FloatingPanel

final class TravelDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let travelDetailView = TravelDetailView()
    
    private let floatingPanelController = FloatingPanelController()
    private let travelDetailPlanViewController = TravelDetailPlanViewController()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelDetailView
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
        configureNavigation()
        configureFloatingPanel()
    }
    
    override func configureAddTarget() {
        travelDetailView.backButton.target = self
        travelDetailView.backButton.action = #selector(tappedBackButton)
        
        travelDetailView.settingButton.target = self
        travelDetailView.settingButton.action = #selector(tappedSettingButton)
    }
    
    override func configureDelegate() {
        floatingPanelController.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = travelDetailView.backButton
        navigationItem.rightBarButtonItem = travelDetailView.settingButton
    }
    
    private func configureFloatingPanel() {
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 15.0
        floatingPanelController.surfaceView.appearance = appearance
        floatingPanelController.contentMode = .fitToBounds
        floatingPanelController.surfaceView.contentPadding = .init(top: 20, left: 0, bottom: 0, right: 0)
        floatingPanelController.layout = TravelDetailFloatingPanelLayout()
        floatingPanelController.set(contentViewController: travelDetailPlanViewController)
        floatingPanelController.addPanel(toParent: self)
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func tappedSettingButton() {
        
    }
}

// MARK: - extensions
extension TravelDetailViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        travelDetailPlanViewController.panelState = fpc.state
        travelDetailPlanViewController.travelDetailPlanView.tableView.reloadData()
    }
}

final class TravelDetailFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    var initialState: FloatingPanelState {
        return .tip
    }
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(fractionalInset: 0.65, edge: .bottom, referenceGuide: .superview),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.42, edge: .bottom, referenceGuide: .superview),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 80.0, edge: .bottom, referenceGuide: .superview),
        ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
