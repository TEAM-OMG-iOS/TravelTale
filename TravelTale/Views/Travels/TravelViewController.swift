//
//  TravelViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class TravelViewController: BaseViewController {
    
    // MARK: - Properties
    
    let travelView = TravelView()
    let travelViewModel = TravelViewModel()
    
    //  childVC
    let travelPlanVC = TravelPlanViewController()
    let travelMemoryVC = TravelMemoryViewController()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = travelView
        addChildViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tappedButton(travelView.planButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    // MARK: - Methods
    
    override func configureStyle() { }
    
    override func configureAddTarget() {
        travelView.planButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        travelView.planButton.tag = 0
        
        
        travelView.memoryButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        travelView.memoryButton.tag = 1
        
    }
    
    func addChildViews() {
        let childVCs = [
            travelPlanVC,
            travelMemoryVC
        ]
        
        childVCs.forEach {
            travelView.addChildView($0.view)
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
            travelView.changeButtonUI(tappedButton: .plan) // 선택한 버튼 컬러 바꾸기
            
        case 1:
            travelPlanVC.view.isHidden = true
            travelMemoryVC.view.isHidden = false
            travelView.changeButtonUI(tappedButton: .memory) // 선택한 버튼 컬러 바꾸기
            
        default:
            travelPlanVC.view.isHidden = false
            travelMemoryVC.view.isHidden = true
            travelView.changeButtonUI(tappedButton: .plan) // 선택한 버튼 컬러 바꾸기
        }
    }
}
