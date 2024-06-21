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
    
    private let dayPopoverVC = PopoverDayViewController()
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    
    var selectedPlace: PlaceDetail? = nil
    var selectedDays: String?
    var selectedTime: Date?
    var travel: Travel? = nil
    var schedule: Schedule? = nil
    var day: String?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedDays), name: .selectedDaysUpdated, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
    }
    
    // MARK: - methods
    override func configureDelegate() {
        memoTV.delegate = self
    }
    
    override func bind() {
        placeContents.text = schedule?.title
        scheduleContents.text = configureInitialScheduleContents(day: day!, date: (self.schedule?.date!)!)
        startTimeContents.text = configureInitialStartTimeContents(date: (self.schedule?.date!)!)
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }
    
    private func bindingDays() {
        scheduleContents.text = selectedDays
    }
    
    private func bindingTime() {
        startTimeContents.text = dateFormat(date: selectedTime ?? Date())
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
        let alert = UIAlertController(title: "경고", message: "작성중인 내용이 저장되지 않습니다. 계속 진행하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureDeleteAlert() {
        let alert = UIAlertController(title: "경고", message: "현재 장소를 삭제합니다. 계속 진행하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            self.realmManager.deleteSchedule(travel: self.travel!, schedule: self.schedule!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func configureInitialScheduleContents(day: String, date: Date) -> String {
        guard let daysCount = Int(day) else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        
        if let targetDate = Calendar.current.date(byAdding: .day, value: daysCount - 1, to: date) {
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
    
    @objc func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        self.bindingDays()
    }
    
    @objc func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        self.bindingTime()
    }
    
    @IBAction func tappedPlaceBtn(_ sender: UIButton) {
        // TODO: - 장소 이동페이지로 이동
    }
    
    @IBAction func tappedCompletedBtn(_ sender: UIButton) {
        realmManager.updateSchedule(schedule: schedule!, placeDetail: selectedPlace, day: selectedDays, date: selectedTime, internalMemo: memoTV.text)
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
