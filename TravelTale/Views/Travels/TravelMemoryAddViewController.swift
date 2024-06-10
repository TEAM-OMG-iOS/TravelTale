//
//  TravelMemoryTravelSelectionViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/10/24.
//

import UIKit

class TravelMemoryAddViewController: BaseViewController {
    
    // MARK: - properties
    let travelMemoryAddView = TravelMemoryAddView()
    
    
    
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryAddView
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - methods
    
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() {
        travelMemoryAddView.
    }
    
    override func bind() { }
    
    
    func configureNavigationBar(withTitle title: String) {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationItem = UINavigationItem(title: title)
        let exitButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = exitButton
        
        navigationBar.items = [navigationItem]
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - objc functions
    @objc func exitTapped() {
        dismiss(animated: true, completion: nil)
    }
}
