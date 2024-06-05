//
//  AddTravelPlaceVC.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit

final class AddTravelPlaceVC: BaseViewController {
    // MARK: - Properties
    let addTravelPlaceView = AddTravelPlaceView()
    
    override func loadView() {
        view = addTravelPlaceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
    }
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {
        addTravelPlaceView.inputBox.addTarget(self, action: #selector(tappedInputBox), for: .touchUpInside)
        addTravelPlaceView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        addTravelPlaceView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    override func bind() {
        
    }
    
    @objc func tappedInputBox() {
        let locationList = AddLocationVC()
        self.present(locationList, animated: true, completion: nil)
    }
    
    @objc func tappedOkButton() {
        let nextVC = AddTravelCalenderVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("작동")
    }
    
    @objc func tappedCancelButton() {
//        let beforeVC =
//        self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: true)
    }
}

// MARK: - AddLocationVC
final class AddLocationVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let addLocationView = AddLocationView()
    
    override func loadView() {
        view = addLocationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
    }
    
    override func configureStyle() {
        
    }
    
    override func configureDelegate() {
        
    }
    
    override func configureAddTarget() {
        
    }
    
    override func bind() {
        
    }
    
    @objc func tappedInputBox() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addLocationView.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath)
        cell.textLabel?.text = addLocationView.locations[indexPath.row]
        return cell
    }
}
