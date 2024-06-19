//
//  TravelUpdateViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/7/24.
//

import UIKit

final class TravelUpdateViewController: BaseViewController {
    
    // MARK: - properties
    private let travelUpdateView = TravelUpdateView()
    
    // MARK: - life cycles
    override func loadView() {
        view = travelUpdateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelUpdateView.placePickImageButton.addTarget(self, action: #selector(tappedPlacePickButton), for: .touchUpInside)
        travelUpdateView.dayRangeButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        travelUpdateView.datePickButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        travelUpdateView.resetDateButton.addTarget(self, action: #selector(tappedResetDateButton), for: .touchUpInside)
        travelUpdateView.textField.addTarget(self, action: #selector(editiedTextField), for: .editingChanged)
        travelUpdateView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        travelUpdateView.backButton.action = #selector(tappedCancelButton)
        travelUpdateView.backButton.target = self
    }
    
    private func updateInputBox(with text: String) {
        travelUpdateView.placePickImageButton.setTitle(text, for: .normal)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "일정 변경"
        navigationItem.leftBarButtonItem = travelUpdateView.backButton
    }
    
    @objc func tappedPlacePickButton() {
        let locationList = TravelAddPlaceModalViewController()
        locationList.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelUpdateView.updatePlaceLabel(text: text)
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = TravelUpdateCalendarViewController()
        calendar.travelUpdateCalendarView.dateCompletion = { [weak self] date in
            guard let self = self else { return }
            
            travelUpdateView.updateDayRangeButton(text: date)
        }
        
        calendar.travelUpdateCalendarView.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelUpdateView.updateDatePickButton(text: text)
        }
        
        self.present(calendar, animated: true)
    }
    
    @objc func editiedTextField() {
        travelUpdateView.buttonColorChanged()
    }
    
    @objc func tappedResetDateButton() {
        travelUpdateView.resetDate()
        travelUpdateView.buttonColorChanged()
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedOkButton() {
        self.navigationController?.popViewController(animated: true)
        // TODO: 데이터 저장 상태로 이동하는 기능
    }
}
