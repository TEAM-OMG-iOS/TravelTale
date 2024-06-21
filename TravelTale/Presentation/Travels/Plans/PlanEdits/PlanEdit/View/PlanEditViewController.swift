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
    private let planEditDateView = PlanEditDateView(monthsLayout: .vertical)
    
    private let realmManager = RealmManager.shared
    
    private var travel: Travel
    
    var editTitle: String?
    var editSido: String?
    var editStartDate: Date?
    var editEndDate: Date?
    
    // MARK: - life cycles
    override func loadView() {
        view = planEditView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    init(travel: Travel) {
        self.travel = travel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    """, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .destructive)
        
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            realmManager.deleteTravel(travel: self.travel)
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
            self.editSido = text
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = PlanEditDateViewController()
        calendar.planEditDateView.dateCompletion = { [weak self] startDate, endDate in
            guard let self = self else { return }
            
            self.editStartDate = startDate
            self.editEndDate = endDate
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            let dateRangeString = "\(startDateString) - \(endDateString)"
            self.planEditView.updateDayRangeButton(text: dateRangeString)
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
        editTitle = planEditView.textField.text
        realmManager.updateTravel(travel: self.travel, title: editTitle ?? "", area: editSido ?? "미정", startDate: editStartDate ?? Date(), endDate: editEndDate ?? Date())
        
        self.navigationController?.popViewController(animated: true)
    }
}
