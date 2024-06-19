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
    private let travelViewModel = TravelViewModel()
    
    //  childVC
    private let travelPlanVC = TravelPlanViewController()
    private let travelMemoryVC = TravelMemoryViewController()
    
    
    // MARK: - life cycles
    override func loadView() {
        addChildViews()
        view = travelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButton(travelView.planButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    // MARK: - methods
    override func configureAddTarget() {
        travelView.planButton.addTarget(
            self,
            action: #selector(tappedButton),
            for: .touchUpInside
        )
        travelView.planButton.tag = 0
        
        travelView.memoryButton.addTarget(
            self,
            action: #selector(tappedButton),
            for: .touchUpInside
        )
        travelView.memoryButton.tag = 1
    }
    
    func addChildViews() {
        let childVCs = [
            travelPlanVC,
            travelMemoryVC
        ]
        
        childVCs.forEach {
            travelView.addConvertableView($0.view)
            self.addChild($0)
            $0.didMove(toParent: self)
        }
    }
    
    
    // MARK: - objc functions
    @objc func tappedButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            travelPlanVC.view.isHidden = false
            travelMemoryVC.view.isHidden = true
            travelView.changeButtonUI(tapped: .plan)
            
        case 1:
            travelPlanVC.view.isHidden = true
            travelMemoryVC.view.isHidden = false
            travelView.changeButtonUI(tapped: .memory)
            
        default:
            travelPlanVC.view.isHidden = false
            travelMemoryVC.view.isHidden = true
            travelView.changeButtonUI(tapped: .plan)
        }
    }
}
