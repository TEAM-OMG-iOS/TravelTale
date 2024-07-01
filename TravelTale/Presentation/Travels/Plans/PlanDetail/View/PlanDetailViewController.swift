//
//  PlanDetailViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/7/24.
//

import UIKit
import FloatingPanel
import MapKit

final class PlanDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let planDetailView = PlanDetailView()
    
    private let floatingPanelController = FloatingPanelController()
    private lazy var planScheduleViewController = PlanScheduleViewController(travel: travel)
    
    var travel: Travel
    
    // MARK: - life cycles
    init(travel: Travel) {
        self.travel = travel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = planDetailView
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
    
    override func bind() {
        planDetailView.bind(travel: travel, tappedDay: 1)
        
        planScheduleViewController.completion = { [weak self] tappedDay in
            guard let self = self else { return }
            
            planDetailView.bind(travel: travel, tappedDay: tappedDay)
        }
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
        configureFloatingPanel()
    }
    
    override func configureAddTarget() {
        planDetailView.backButton.target = self
        planDetailView.backButton.action = #selector(tappedBackButton)
        
        planDetailView.settingButton.target = self
        planDetailView.settingButton.action = #selector(tappedSettingButton)
    }
    
    override func configureDelegate() {
        planDetailView.mapView.delegate = self
        floatingPanelController.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = planDetailView.backButton
        navigationItem.rightBarButtonItem = planDetailView.settingButton
    }
    
    private func configureFloatingPanel() {
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 15.0
        floatingPanelController.surfaceView.appearance = appearance
        floatingPanelController.contentMode = .fitToBounds
        floatingPanelController.surfaceView.contentPadding = .init(top: 20, left: 0, bottom: 0, right: 0)
        floatingPanelController.layout = TravelDetailFloatingPanelLayout()
        floatingPanelController.set(contentViewController: planScheduleViewController)
        floatingPanelController.addPanel(toParent: self)
    }
    
    @objc private func tappedBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func tappedSettingButton() {
        let planEditVC = PlanEditViewController(travel: travel)
        
        planEditVC.completion = { [weak self] _ in
            guard let self = self else { return }
            
            planDetailView.bind(travel: travel, tappedDay: 1)
            
            guard let cell = planScheduleViewController.planScheduleView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PlanScheduleHeaderCell else { return }
            cell.collectionView.reloadData()
        }
        
        navigationController?.pushViewController(planEditVC, animated: true)
    }
}

// MARK: - extensions
extension PlanDetailViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        planScheduleViewController.panelState = fpc.state
        planScheduleViewController.planScheduleView.tableView.reloadData()
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

extension PlanDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .black
            renderer.lineWidth = 2.0
            
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
