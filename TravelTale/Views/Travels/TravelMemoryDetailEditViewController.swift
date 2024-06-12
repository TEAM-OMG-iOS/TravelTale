//
//  TravelMemoryDetailEditViewController.swift
//  TravelTale
//
//  Created by 유림 on 6/12/24.
//

import UIKit

class TravelMemoryDetailEditViewController: BaseViewController {
    
    // MARK: - properties
    private let travelMemoryDetailEditView = TravelMemoryDetailEditView()
    private var travelData: Travel
    
    
    // MARK: - life cycles
    override func loadView() {
        view = travelMemoryDetailEditView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("former width: \(travelMemoryDetailEditView.formerButton.bounds.width), confirm width: \(travelMemoryDetailEditView.confirmButton.bounds.width)")
    }
    
    
    // MARK: - methods
    init(travelData: Travel) {
        self.travelData = travelData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureDelegate() {
//        travelMemoryDetailEditView.collectionView.dataSource = self
//
//        travelMemoryAddView.tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)
        
        
    }
    
    override func configureAddTarget() {
        travelMemoryDetailEditView.exitButton.target = self
        travelMemoryDetailEditView.exitButton.action = #selector(tappedExitButton)
    }
    
    override func bind() { 
        travelMemoryDetailEditView.bind(travel: travelData)
    }
    
    func configureNavigationBarItems() {
        navigationItem.title = "추억 남기기"
        navigationItem.leftBarButtonItem = travelMemoryDetailEditView.exitButton
      }
    
    
    // MARK: - objc functions
    @objc func tappedExitButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - extensions
//extension TravelMemoryDetailEditViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
