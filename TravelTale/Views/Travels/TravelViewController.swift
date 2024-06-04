//
//  TravelViewController.swift
//  TravelTale
//
//  Created by 김정호 on 6/3/24.
//

import UIKit

class TravelViewController: UIViewController {
    
    let travelView = TravelView()
    
    override func loadView() {
        view = travelView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        travelView.addButtonLabel.text = "새 여행 추가"
    }
    
    

}
