//
//  TravelAddLocationViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/11/24.
//

import UIKit

final class TravelAddLocationViewController: BaseViewController {
    
    // MARK: - properties
    private let travelAddLocationView = TravelAddLocationView()
    var travelAddPlaceVC = TravelAddPlaceViewController()
    var travelRescheduleVC = TravelRescheduleViewController()
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelAddLocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - methods
    override func configureStyle() {
        travelAddLocationView.tableView.reloadData()
    }
    
    override func configureDelegate() {
        travelAddLocationView.tableView.dataSource = self
        travelAddLocationView.tableView.delegate = self
        
        travelAddLocationView.tableView.register(TravelLocationTableViewCell.self,
                                           forCellReuseIdentifier: TravelLocationTableViewCell.identifier)
    }
}

// MARK: - extensions
extension TravelAddLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelAddLocationView.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelLocationTableViewCell.identifier, for: indexPath) as? TravelLocationTableViewCell else { return TravelLocationTableViewCell() }
        cell.locationLabel.text = travelAddLocationView.locations[indexPath.row]
        
        return cell
    }
}

extension TravelAddLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TravelLocationTableViewCell else { return }
        if let text = cell.locationLabel.text {
            travelAddPlaceVC.updateInputBox(with: text)
            travelRescheduleVC.updateInputBox(with: text)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
