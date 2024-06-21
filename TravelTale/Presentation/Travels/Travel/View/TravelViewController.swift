//
//  TravelViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

final class TravelViewController: BaseViewController {
    
    // MARK: - properties
    private let travelView = TravelView()
    
    private let planVC = PlanViewController()
    private let travelMemoryVC = TravelMemoryViewController()
    
    lazy var currentTappedButton: UIButton = travelView.planButton
    
    // MARK: - life cycles
    override func loadView() {
        addChildViews()
        view = travelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tappedButton(currentTappedButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        [travelView.planButton,
         travelView.memoryButton].forEach {
            $0.addTarget(self,
                         action: #selector(tappedButton),
                         for: .touchUpInside)
        }
    }
    
    private func addChildViews() {
        let childVCs = [
            planVC,
            travelMemoryVC
        ]
        
        childVCs.forEach {
            travelView.addConvertableView($0.view)
            self.addChild($0)
            $0.didMove(toParent: self)
        }
    }
    
    private func showOnlyView(viewToShow: UIView) {
        let views = [planVC.view,
                     travelMemoryVC.view]
        views.forEach { $0?.isHidden = ($0 != viewToShow) }
    }
    
    @objc func tappedButton(_ sender: UIButton) {
        switch sender {
        case travelView.memoryButton:
            showOnlyView(viewToShow: travelMemoryVC.view)
            travelView.changeButtonUI(tapped: sender)
            currentTappedButton = travelView.memoryButton
            
        default:
            showOnlyView(viewToShow: planVC.view)
            travelView.changeButtonUI(tapped: sender)
            currentTappedButton = travelView.planButton
        }
    }
}
