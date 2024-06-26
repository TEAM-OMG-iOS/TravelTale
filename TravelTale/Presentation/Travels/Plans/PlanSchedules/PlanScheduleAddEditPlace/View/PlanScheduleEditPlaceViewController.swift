//
//  PlanScheduleEditPlaceViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/13/24.
//

import UIKit

final class PlanScheduleEditPlaceViewController: BaseViewController {
    
    // MARK: - properties
    @IBOutlet weak var placeContents: UILabel!
    @IBOutlet weak var startTimeContents: UILabel!
    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var memoTV: UITextView!
    @IBOutlet weak var scheduleContents: UILabel!
    @IBOutlet weak var scheduleBtn: UIButton!
    @IBOutlet weak var naviTitle: UINavigationItem!
    @IBOutlet weak var completedBtn: UIButton!
    
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    private let userDefaults = UserDefaultsManager()
    private let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
"""
    
    private lazy var dayPopoverVC = PopoverDayViewController(data: configureData(alldays: allDays, travel: travel), travel: travel)
    
    private var selectedDays: String?
    private var selectedTime: Date?
    private var travel: Travel
    private var schedule: Schedule
    private var selectedDay: String
    private var allDays: String
    private var selectedPlace: PlaceDetail {
        didSet {
            checkPlaceDetail()
        }
    }
    
    // MARK: - life cycles
    init(travel: Travel, selectedPlace: PlaceDetail, schedule: Schedule, selectedDay: String, allDays: String) {
        self.travel = travel
        self.selectedPlace = selectedPlace
        self.schedule = schedule
        self.selectedDay = selectedDay
        self.allDays = allDays
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedDays), name: .selectedDaysUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceContents), name: .placeSelected, object: nil)
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
    override func configureDelegate() {
        memoTV.delegate = self
    }
    
    override func bind() {
        placeContents.text = schedule.title
        scheduleContents.text = configureInitialSchedule(selectedDay: selectedDay, alldays: allDays, travel: travel)
        startTimeContents.text = configureInitialStartTimeContents(date: (self.schedule.date!))
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
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
    
    private func configureBackAlert() {
        let alert = UIAlertController(title: "경고", message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    private func configureDeleteAlert() {
        let alert = UIAlertController(title: "경고", message: """
현재 장소를 삭제합니다.
계속 진행하시겠습니까?
""", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.realmManager.deleteSchedule(travel: self.travel, schedule: self.schedule)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    private func configureInitialSchedule(selectedDay: String, alldays: String, travel: Travel) -> String {
        guard let daysCount = Int(selectedDay), let totalDays = Int(alldays), daysCount > 0, daysCount <= totalDays else {
                return ""
            }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        
        if let targetDate = Calendar.current.date(byAdding: .day, value: daysCount - 1, to: travel.startDate) {
            let dateString = formatter.string(from: targetDate)
            return "Day \(daysCount) | \(dateString)"
        } else {
            return ""
        }
    }
    
    private func configureInitialStartTimeContents(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    private func configureData(alldays: String, travel: Travel) -> [String] {
        guard let daysCount = Int(alldays) else {
            return []
        }
        var results = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        
        for i in 0..<daysCount {
            if let newDate = Calendar.current.date(byAdding: .day, value: i, to: travel.startDate) {
                let dateString = formatter.string(from: newDate)
                results.append("Day \(i + 1) | \(dateString)")
            }
        }
        return results
    }
    
    private func checkPlaceDetail() {
        self.placeContents.text = self.selectedPlace.title
    }
    
    private func extractDayNumber(from formattedString: String) -> String? {
        let components = formattedString.split(separator: " ")
        if components.count > 1 {
            let dayNumber = String(components[1])
            return dayNumber
        }
        return ""
    }
    
    @objc func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        scheduleContents.text = self.selectedDays
    }
    
    @objc func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        startTimeContents.text = dateFormat(date: self.selectedTime ?? Date())
    }
    
    @objc func updatePlaceContents(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedPlace = userInfo["dataDetail"] as? PlaceDetail else { return }
        
        self.selectedPlace = selectedPlace
        self.placeContents.text = self.selectedPlace.title
    }
    
    @IBAction func tappedPlaceBtn(_ sender: UIButton) {
        let nextVC = SearchResultViewController()
        userDefaults.setTabType(type: .travel)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func tappedCompletedBtn(_ sender: UIButton) {
        realmManager.updateSchedule(schedule: schedule, placeDetail: selectedPlace, day: selectedDays ?? extractDayNumber(from: scheduleContents.text!), date: selectedTime, internalMemo: memoTV.text)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedExitBtn(_ sender: UIButton) {
        configureBackAlert()
    }
    
    @IBAction func tappedDeleteBtn(_ sender: UIButton) {
        configureDeleteAlert()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - extensions
extension PlanScheduleEditPlaceViewController: UIPopoverPresentationControllerDelegate {
    @IBAction func tappedScheduleBtn(_ sender: UIButton) {
        configurePopover(for: dayPopoverVC, sourceButton: scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    @IBAction func tappedStartTimeBtn(_ sender: UIButton) {
        configurePopover(for: timePopoverVC, sourceButton: startTimeBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
}

extension PlanScheduleEditPlaceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "메모를 입력해주세요" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모를 입력해주세요"
            textView.textColor = .gray80
        }
    }
}