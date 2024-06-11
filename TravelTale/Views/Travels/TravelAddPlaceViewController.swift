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
        travelAddPlaceView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddPlaceView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelAddPlaceView.backButtonItem.action = #selector(tappedToRootView)
        travelAddPlaceView.backButtonItem.target = self
    }
    
    override func bind() {
        
    }
    
    private func customNavigationBar() {
        navigationItem.titleView = travelAddPlaceView.pageTitleLabel
        self.navigationItem.leftBarButtonItem = travelAddPlaceView.backButtonItem
    }
    
    func updateInputBox(with text: String) {
        travelAddPlaceView.placePickButton.setTitle(text, for: .normal)
    }
    
    @objc func tappedInputBox() {
        let locationList = AddLocationViewController()
        if let sheet = locationList.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            locationList.travelAddPlaceVC = self
            self.present(locationList, animated: true, completion: nil)
        }
    }
    
    @objc func tappedOkButton() {
        let nextVC = TravelAddCalenderViewController()
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
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
    var travelRescheduleVC = TravelRescheduleViewController()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = addLocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Methods
    
    override func configureStyle() {
        addLocationView.tableView.reloadData()
    }
    
    override func configureDelegate() {
        addLocationView.tableView.dataSource = self
        addLocationView.tableView.delegate = self
        
        addLocationView.tableView.register(TravelLocationTableViewCell.self, forCellReuseIdentifier: TravelLocationTableViewCell.identifier)
    }
    
    override func configureAddTarget() {
        
    }
    
    override func bind() {
    }
}

// MARK: - Extensions

extension AddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addLocationView.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelLocationTableViewCell.identifier, for: indexPath) as? TravelLocationTableViewCell else { return TravelLocationTableViewCell() }
        cell.locationLabel.text = addLocationView.locations[indexPath.row]
        
        return cell
    }
}

extension AddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TravelLocationTableViewCell else { return }
        if let text = cell.locationLabel.text {
            travelAddPlaceVC.updateInputBox(with: text)
            travelRescheduleVC.updateInputBox(with: text)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
