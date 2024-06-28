//
//  PlanScheduleEditPlaceViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/13/24.
//

import UIKit

final class PlanScheduleEditPlaceViewController: BaseViewController {
    
    // MARK: - properties
    private let addEditView = PlanScheduleAddEditPlaceView()
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    private let userDefaults = UserDefaultsManager.shared
    
    private lazy var dayPopoverVC = PopoverDayViewController(data: addEditView.configureData(allDays: allDays, travel: travel), travel: travel)
    
    private var placeDetailIsChanged: Bool?
    private var selectedTime: Date?
    private var travel: Travel
    private var schedule: Schedule
    private var selectedDate: String?
    private var selectedDay: String
    private var allDays: String
    private var selectedPlace: PlaceDetail? {
        didSet {
            placeDetailIsChanged = true
            addEditView.placeContents.text = self.selectedPlace?.title
            addEditView.checkBlackText()
        }
    }
    
    var completion: ((Schedule) -> ())?
    
    // MARK: - life cycles
    init(travel: Travel, schedule: Schedule, selectedDay: String, allDays: String, selectedTime: Date) {
        self.travel = travel
        self.schedule = schedule
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
        addEditView.changeContentsText()
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
        addEditView.placeContents.text = schedule.title
        addEditView.scheduleContents.text = addEditView.configureInitialSchedule(selectedDay: selectedDay, alldays: allDays, travel: travel)
        addEditView.startTimeContents.text = addEditView.configureInitialStartTimeContents(date: (self.schedule.date ?? Date()))
        addEditView.memoTV.text = schedule.internalMemo
    }
    
    private func configureNavigationBar() {
        navigationItem.title = addEditView.editVCNaviLabel
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
        
        self.selectedDay = addEditView.extractDayNumber(from: selectedDays)
        self.selectedDate = selectedDays
        addEditView.scheduleContents.text = self.selectedDate
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
        
        self.selectedPlace = selectedPlace
        addEditView.placeContents.text = self.selectedPlace?.title
        addEditView.checkBlackText()
    }
    
    @objc private func tappedPlaceBtn(_ sender: UIButton) {
        let nextVC = SearchViewController()
        userDefaults.setTabType(type: .travel)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func tappedCompletedBtn(_ sender: UIButton) {
        if placeDetailIsChanged == true {
            if let selectedPlace {
                if let selectedTime {
                    if let selectedDate {
                        realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: addEditView.configureScheduleDate(selectedDay: selectedDate), withTimeFrom: selectedTime), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                        completion?(self.schedule)
                        navigationController?.popViewController(animated: true)
                    } else {
                        realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: schedule.date ?? Date(), withTimeFrom: selectedTime), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                        completion?(self.schedule)
                        navigationController?.popViewController(animated: true)
                    }
                } else {
                    if let selectedDate {
                        realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: addEditView.configureScheduleDate(selectedDay: selectedDate), withTimeFrom: schedule.date ?? Date()), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                        completion?(self.schedule)
                        navigationController?.popViewController(animated: true)
                    } else {
                        realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: schedule.date ?? Date(), withTimeFrom: schedule.date ?? Date()), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                        completion?(self.schedule)
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            if let selectedTime {
                if let selectedDate {
                    realmManager.updateSchedule(schedule: schedule, day: selectedDay, date: addEditView.combineDate(date: addEditView.configureScheduleDate(selectedDay: selectedDate), withTimeFrom: selectedTime), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                    completion?(self.schedule)
                    navigationController?.popViewController(animated: true)
                } else {
                    realmManager.updateSchedule(schedule: schedule, day: selectedDay, date: addEditView.combineDate(date: schedule.date ?? Date(), withTimeFrom: selectedTime), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                    completion?(self.schedule)
                    navigationController?.popViewController(animated: true)
                }
            } else {
                if let selectedDate {
                    realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: addEditView.configureScheduleDate(selectedDay: selectedDate), withTimeFrom: schedule.date ?? Date()), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                    completion?(self.schedule)
                    navigationController?.popViewController(animated: true)
                } else {
                    realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDay, date: addEditView.combineDate(date: schedule.date ?? Date(), withTimeFrom: schedule.date ?? Date()), internalMemo: addEditView.checkMemo(textColor: addEditView.memoTV.textColor ?? .gray80))
                    completion?(self.schedule)
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    @objc private func tappedExitBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "경고", message: addEditView.alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - extensions
extension PlanScheduleEditPlaceViewController: UIPopoverPresentationControllerDelegate {
    @objc private func tappedScheduleBtn(_ sender: UIButton) {
        configurePopover(for: dayPopoverVC, sourceButton: addEditView.scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    @objc private func tappedStartTimeBtn(_ sender: UIButton) {
        configurePopover(for: timePopoverVC, sourceButton: addEditView.startTimeBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
}

extension PlanScheduleEditPlaceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        addEditView.setBeginText(textView: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        addEditView.setEndText(textView: textView)
    }
}
