//
//  TravelRescheduleVieweController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/7/24.
//

import UIKit

final class TravelRescheduleViewController: BaseViewController {
    
    // MARK: - properties
    private let travelRescheduleView = TravelRescheduleView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelRescheduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelRescheduleView.placePickImageButton.addTarget(self, action: #selector(tappedPlacePickButton), for: .touchUpInside)
        travelRescheduleView.dayRangeButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        travelRescheduleView.datePickButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        travelRescheduleView.resetDateButton.addTarget(self, action: #selector(tappedResetDate), for: .touchUpInside)
        travelRescheduleView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
        travelRescheduleView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelRescheduleView.backButton.action = #selector(tappedCancelButton)
        travelRescheduleView.backButton.target = self
    }
    
    private func updateInputBox(with text: String) {
        travelRescheduleView.placePickImageButton.setTitle(text, for: .normal)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "일정 변경"
        navigationItem.leftBarButtonItem = travelRescheduleView.backButton
    }
    
    @objc func tappedPlacePickButton() {
        let locationList = TravelAddLocationViewController()
        locationList.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelRescheduleView.placePickLabel.text = text
            travelRescheduleView.placePickLabel.textColor = .black
        }
        
        self.present(locationList, animated: true, completion: nil)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = TravelRenewCalendarViewController()
        calendar.travelRenewCalendarView.dateCompletion = { [weak self] date in
            guard let self = self else { return }
            
            travelRescheduleView.dayRangeButton.setTitle(date, for: .normal)
        }
        
        calendar.travelRenewCalendarView.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelRescheduleView.datePickButton.setTitle(text, for: .normal)
        }
        
        self.present(calendar, animated: true, completion: nil)
    }
    
    @objc func changedButtonColor() {
        travelRescheduleView.buttonColorChanged()
    }
    
    @objc func tappedResetDate() {
        travelRescheduleView.dayRangeButton.setTitle("2024.05.08 - 2024.05.11", for: .normal)
        travelRescheduleView.datePickButton.setTitle("3박 4일", for: .normal)
        travelRescheduleView.buttonColorChanged()
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedOkButton() {
        self.navigationController?.popViewController(animated: true)
        // TODO: 데이터 저장 상태로 이동하는 기능
    }
}
