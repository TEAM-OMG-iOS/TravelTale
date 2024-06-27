//
//  PlanScheduleAddPlaceViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class PlanScheduleAddPlaceViewController: BaseViewController {
    
    // MARK: - properties
    private let addEditView = PlanScheduleAddEditPlaceView()
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    private let userDefaults = UserDefaultsManager.shared
    private let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
"""
    private lazy var dayPopoverVC = PopoverDayViewController(data: addEditView.configureData(allDays: allDays, travel: travel), travel: travel)
    
    private var selectedDays: String?
    private var selectedTime: Date?
    private var travel: Travel
    private var selectedDay: String
    private var allDays: String
    
    var completion: ((Travel) -> ())?
    var placeDetail: PlaceDetail? {
        didSet {
            addEditView.placeContents.text = self.placeDetail?.title
            addEditView.checkBlackText()
        }
    }
    
    // MARK: - life cycles
    init(travel: Travel, selectedDay: String, allDays: String) {
        self.travel = travel
        self.selectedDay = selectedDay
        self.allDays = allDays
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = addEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedDays), name: .selectedDaysUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceContents), name: .placeSelected, object: nil)
        addEditView.checkBlackText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        addEditView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        addEditView.backButton.target = self
        addEditView.backButton.action = #selector(tappedExitBtn)
        addEditView.placeBtn.addTarget(self, action: #selector(tappedPlaceBtn), for: .touchUpInside)
        addEditView.scheduleBtn.addTarget(self, action: #selector(tappedScheduleBtn), for: .touchUpInside)
        addEditView.startTimeBtn.addTarget(self, action: #selector(tappedStartTimeBtn), for: .touchUpInside)
        addEditView.completedBtn.addTarget(self, action: #selector(tappedCompletedBtn), for: .touchUpInside)
    }
    
    override func bind() {
        addEditView.scheduleContents.text = addEditView.configureInitialSchedule(selectedDay: selectedDay, alldays: allDays, travel: travel)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = addEditView.addVCNaviLabel
        navigationItem.leftBarButtonItem = addEditView.backButton
    }
    
    private func configurePopover(for popoverVC: UIViewController, sourceButton: UIButton) {
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 300, height: 200)
        let popoverPresentationController = popoverVC.popoverPresentationController
        popoverPresentationController?.sourceView = sourceButton
        popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(x: sourceButton.bounds.maxX - 50, y: sourceButton.bounds.midY + 10),
            size: .zero
        )
        popoverPresentationController?.permittedArrowDirections = .up
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @objc private func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        addEditView.scheduleContents.text = self.selectedDays
        addEditView.checkBlackText()
    }
    
    @objc private func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        addEditView.startTimeContents.text = addEditView.dateFormat(date: self.selectedTime ?? Date())
        addEditView.checkBlackText()
    }
    
    @objc private func updatePlaceContents(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedPlace = userInfo["placeSelected"] as? PlaceDetail else { return }
        self.placeDetail = selectedPlace
        addEditView.placeContents.text = self.placeDetail?.title
        addEditView.checkBlackText()
    }
    
    @objc private func tappedPlaceBtn(_ sender: UIButton) {
        let nextVC = SearchViewController()
        userDefaults.setTabType(type: .travel)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func tappedCompletedBtn(_ sender: UIButton) {
        if let placeDetail {
            realmManager.createSchedule(day: (addEditView.extractDayNumber(from: selectedDays ?? "") ?? selectedDay), date: selectedTime ?? Date(), travel: travel, placeDetail: placeDetail, memo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
            completion?(self.travel)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func tappedExitBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "경고", message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
}

// MARK: - extensions
extension PlanScheduleAddPlaceViewController: UIPopoverPresentationControllerDelegate {
    @objc func tappedScheduleBtn(_ sender: UIButton) {
        configurePopover(for: dayPopoverVC, sourceButton: addEditView.scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    @objc func tappedStartTimeBtn(_ sender: UIButton) {
        configurePopover(for: timePopoverVC, sourceButton: addEditView.startTimeBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
}

extension PlanScheduleAddPlaceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        addEditView.setBeginText(textView: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        addEditView.setEndText(textView: textView)
    }
}
