//
//  PlanEditViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/7/24.
//

import UIKit

final class PlanEditViewController: BaseViewController {
    
    // MARK: - properties
    private let planEditView = PlanEditView()
    
    // MARK: - life cycles
    override func loadView() {
        view = planEditView
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
        planEditView.placePickImageButton.addTarget(self, action: #selector(tappedPlacePickButton), for: .touchUpInside)
        planEditView.dayRangeButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        planEditView.datePickButton.addTarget(self, action: #selector(tappedDatePickButton), for: .touchUpInside)
        planEditView.resetDateButton.addTarget(self, action: #selector(tappedResetDateButton), for: .touchUpInside)
        planEditView.textField.addTarget(self, action: #selector(editiedTextField), for: .editingChanged)
        planEditView.okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchUpInside)
        planEditView.backButton.action = #selector(tappedCancelButton)
        planEditView.backButton.target = self
        planEditView.deleteButton.action = #selector(tappedDeleteButton)
        planEditView.deleteButton.target = self
    }
    
    private func updateInputBox(with text: String) {
        planEditView.placePickImageButton.setTitle(text, for: .normal)
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "일정 변경"
        navigationItem.leftBarButtonItem = planEditView.backButton
    }
    
    private func configureDeleteItem() {
        navigationItem.rightBarButtonItem = planEditView.deleteButton
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
        let locationList = PlanAddSidoModalViewController()
        locationList.completion = { [weak self] text in
            guard let self = self else { return }
            
            planEditView.updatePlaceLabel(text: text)
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = PlanEditDateViewController()
        calendar.planEditDateView.dateCompletion = { [weak self] date in
            guard let self = self else { return }
            
            planEditView.updateDayRangeButton(text: date)
        }
        
        calendar.planEditDateView.completion = { [weak self] text in
            guard let self = self else { return }
            
            planEditView.updateDatePickButton(text: text)
        }
        
        self.present(calendar, animated: true)
    }
    
    @objc func editiedTextField() {
        planEditView.buttonColorChanged()
    }
    
    @objc func tappedResetDateButton() {
        planEditView.resetDate()
        planEditView.buttonColorChanged()
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedOkButton() {
        self.navigationController?.popViewController(animated: true)
        // TODO: 데이터 저장 상태로 이동하는 기능
    }
}
