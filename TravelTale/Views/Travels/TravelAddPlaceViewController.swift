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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        travelAddPlaceView.startLoadingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar()
    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {
        travelAddPlaceView.placePickButton.addTarget(self, action: #selector(tappedInputBox), for: .touchUpInside)
        travelAddPlaceView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddPlaceView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func bind() {
        
    }
    
    private func customNavigationBar() {
        let image = UIImage(systemName: "chevron.backward")
        let backButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(tappedToRootView))
        backButtonItem.tintColor = .gray90
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    func updateInputBox(with text: String) {
        travelAddPlaceView.placePickButton.setTitle(text, for: .normal)
    }
    
    @objc func tappedInputBox() {
        let locationList = AddLocationViewController()
        locationList.travelAddPlaceVC = self
        self.present(locationList, animated: true, completion: nil)
    }

    @objc func tappedOkButton() {
        let nextVC = TravelAddCalenderViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
        print("작동")
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - AddLocationVC

final class AddLocationViewController: BaseViewController {
    
    // MARK: - Properties
    let addLocationView = AddLocationView()
    var travelAddPlaceVC = TravelAddPlaceViewController()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = addLocationView
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

