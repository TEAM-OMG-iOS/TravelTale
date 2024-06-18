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
        travelUpdateView.resetDateButton.addTarget(self, action: #selector(tappedResetDate), for: .touchUpInside)
        travelUpdateView.textField.addTarget(self, action: #selector(changedButtonColor), for: .editingChanged)
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
            
            travelUpdateView.placePickLabel.text = text
            travelUpdateView.placePickLabel.textColor = .black
        }
        
        self.present(locationList, animated: true, completion: nil)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = TravelUpdateCalendarViewController()
        calendar.travelUpdateCalendarView.dateCompletion = { [weak self] date in
            guard let self = self else { return }
            
            travelUpdateView.dayRangeButton.setTitle(date, for: .normal)
        }
        
        calendar.travelUpdateCalendarView.completion = { [weak self] text in
            guard let self = self else { return }
            
            travelUpdateView.datePickButton.setTitle(text, for: .normal)
        }
        
        self.present(calendar, animated: true, completion: nil)
    }
    
    @objc func changedButtonColor() {
        travelUpdateView.buttonColorChanged()
    }
    
    @objc func tappedResetDate() {
        travelUpdateView.dayRangeButton.setTitle("2024.05.08 - 2024.05.11", for: .normal)
        travelUpdateView.datePickButton.setTitle("3박 4일", for: .normal)
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
