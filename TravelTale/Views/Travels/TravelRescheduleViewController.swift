//
//  TravelRescheduleVieweController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/7/24.
//

import UIKit

final class TravelRescheduleViewController: BaseViewController {
    
    let travelRescheduleView = TravelRescheduleView()
    
    override func loadView() {
        view = travelRescheduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() { }
    
    override func bind() { }
}
