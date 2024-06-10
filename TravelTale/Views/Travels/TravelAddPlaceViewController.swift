//
//  TravelAddPlaceViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class TravelAddPlaceViewController: BaseViewController {
    
    // MARK: - Properties
    
    let travelAddPlaceView = TravelAddPlaceView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = travelAddPlaceView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {

    }
    
    override func bind() {
        
    }
}

// MARK: - AddLocationVC

final class AddLocationViewController: BaseViewController {
    
    let addLocationView = AddLocationView()
    var travelAddPlaceVC = TravelAddPlaceViewController()
    
    override func loadView() {
        view = addLocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
}
