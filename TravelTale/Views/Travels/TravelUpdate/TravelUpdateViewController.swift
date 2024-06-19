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
        configureDeleteItem()
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
        travelUpdateView.deleteButton.action = #selector(tappedDeleteButton)
        travelUpdateView.deleteButton.target = self
    }
    
    private func updateInputBox(with text: String) {
        travelUpdateView.placePickImageButton.setTitle(text, for: .normal)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "일정 변경"
        navigationItem.leftBarButtonItem = travelUpdateView.backButton
    }
    
    private func configureDeleteItem() {
        navigationItem.rightBarButtonItem = travelUpdateView.deleteButton
    }

    private func presentAlert() {
        let alert = UIAlertController(title: "경고", message: """
    계획된 모든 일정이 삭제됩니다.
    그대로 진행하시겠습니까?
    """, preferredStyle: UIAlertController.Style.alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            // TODO: 해당 셀(여행 계획) 삭제
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func tappedDeleteButton() {
        presentAlert()
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
