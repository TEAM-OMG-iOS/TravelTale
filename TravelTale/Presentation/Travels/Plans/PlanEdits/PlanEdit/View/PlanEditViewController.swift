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
    
    private let realmManager = RealmManager.shared
    
    private let travel: Travel
    
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
        beforeChangeUI()
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
    
    private func beforeChangeUI() {
        planEditView.textField.text = travel.title
        planEditView.placePickLabel.text = travel.area
        planEditView.placePickLabel.textColor = .black
        resetDate()
    }
    
    private func resetDate() {
        let dateRangeString = DateFormatter().dateRangeString(startDate: travel.startDate,
                                                              endDate: travel.endDate )
        let daysString = Calendar.current.dateComponents([.day], from: travel.startDate,
                                                         to: travel.endDate ).day ?? 0
        
        planEditView.dayRangeButton.configureButton(fontColor: .gray90,
                                                    font: .pretendard(size: 16, weight: .medium),
                                                    text: dateRangeString)
        planEditView.datePickButton.configureButton(font: .pretendard(size: 16, weight: .medium),
                                                    text: travel.startDate == travel.endDate ? "당일치기" : "\(daysString)박 \(daysString + 1)일")
        
        editTitle = planEditView.textField.text
        editStartDate = travel.startDate
        editEndDate = travel.endDate
        
        realmManager.updateTravel(travel: self.travel,
                                  title: editTitle ?? travel.title,
                                  area: editSido ?? travel.area,
                                  startDate: travel.startDate,
                                  endDate: travel.endDate)
    }
    
    private func updateTravel() {
        editTitle = planEditView.textField.text
        realmManager.updateTravel(travel: self.travel,
                                  title: editTitle ?? travel.title,
                                  area: editSido ?? travel.area,
                                  startDate: editStartDate ?? travel.startDate,
                                  endDate: editEndDate ?? travel.endDate)
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
    
    private func presentDeleteAlert() {
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
    
    private func presentDateAlert() {
        let travelRange = Calendar.current.dateComponents([.day], from: travel.startDate,
                                                          to: travel.endDate ).day ?? 0
        let editRange = Calendar.current.dateComponents([.day], from: editStartDate ?? Date(),
                                                        to: editEndDate ?? Date()).day ?? 0
        
        if travelRange > editRange {
            let alert = UIAlertController(title: "경고", message: """
    수정된 일정만큼 일부 삭제될 수 있습니다.
    그대로 진행하시겠습니까?
    """, preferredStyle: UIAlertController.Style.alert)
            
            let cancel = UIAlertAction(title: "취소", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                
                resetDate()
                
                self.dismiss(animated: true)
            }
            
            let ok = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                updateTravel()
                
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(cancel)
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
        } else {
            updateTravel()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func tappedDeleteButton() {
        presentDeleteAlert()
    }
    
    @objc func tappedPlacePickButton() {
        let locationList = PlanAddSidoModalViewController()
        
        locationList.configureSidoView()
        locationList.completion = { [weak self] sido in
            guard let self = self else { return }
            
            planEditView.updatePlaceLabel(text: sido)
            self.editSido = sido.name
        }
        
        self.present(locationList, animated: true)
    }
    
    @objc func tappedDatePickButton() {
        let calendar = PlanEditDateViewController()
        calendar.planEditDateView.dateCompletion = { [weak self] startDate, endDate in
            guard let self = self else { return }
            
            self.editStartDate = startDate
            self.editEndDate = endDate
            
            let dateRangeString = DateFormatter().dateRangeString(startDate: startDate, endDate: endDate)
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
        resetDate()
        planEditView.buttonColorChanged()
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedOkButton() {
        presentDateAlert()
    }
}

// MARK: - extentions
extension DateFormatter {
    func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }
    
    func dateRangeString(startDate: Date, endDate: Date) -> String {
        let startDateString = dateFormatter().string(from: startDate)
        let endDateString = dateFormatter().string(from: endDate)
        return "\(startDateString) - \(endDateString)"
    }
}
