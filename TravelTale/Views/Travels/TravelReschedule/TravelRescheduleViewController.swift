//
//  TravelRescheduleVieweController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/7/24.
//

import UIKit

final class TravelRescheduleViewController: BaseViewController {
    
    let travelRescheduleView = TravelRescheduleView()
    let addLocationView = LocationView()
    let travelAddCalenderView = TravelAddCalenderView()
    
    override func loadView() {
        view = travelRescheduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureStyle() { }
    
    override func configureDelegate() { }
    
    override func configureAddTarget() {
        travelRescheduleView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
        travelRescheduleView.okButton.addTarget(self, action: #selector(tappedSetAlert), for: .touchUpInside)
        travelRescheduleView.placePickImageButton.addTarget(self, action: #selector(tappedPlacePickButton), for: .touchUpInside)
        travelRescheduleView.datePickButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
    }
    
    override func bind() { }
    
    func updateInputBox(with text: String) {
        travelRescheduleView.placePickImageButton.setTitle(text, for: .normal)
    }
    
    @objc func tappedPlacePickButton() {
        let locationList = TravelAddLocationViewController()
        if let sheet = locationList.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            locationList.completion = { [weak self] text in
                guard let self = self else { return }
                
                travelRescheduleView.placePickLabel.text = text
                travelRescheduleView.placePickLabel.textColor = .black
            }
            
            self.present(locationList, animated: true, completion: nil)
        }
    }
    
    @objc func tappedDatePickButton() {
        let calendar = TravelRenewCalendarViewController(monthsLayout: .vertical)
        if let sheet = calendar.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            calendar.completion = { [weak self] text in
                guard let self = self else { return }
                
                travelRescheduleView.dateLabel.text = text
            }
            
            self.present(calendar, animated: true, completion: nil)
        }
    }
    
    @objc func changedButtonColor() {
        travelRescheduleView.buttonColorChanged()
    }
    
    @objc func tappedSetAlert() {
        self.present(travelRescheduleView.alert, animated: true, completion: nil)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
