//
//  PlanScheduleAddPlaceViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

final class PlanScheduleAddPlaceViewController: BaseViewController {
    
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
    
    var selectedDays: String?
    var selectedTime: Date?
    var travel: Travel? = nil
    var placeDetail: PlaceDetail? = nil
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
        scheduleContents.text = configureInitialSchedule(day: day!, travel: travel!)
    }
    
    private func checkBlackText() {
        var placeIsBlack = false
        var startTimeIsBlack = false
        
        if placeContents.text != "어디로" {
            placeContents.textColor = .black
            placeIsBlack = true
        } else {
            placeContents.textColor = .gray80
        }
        
        if startTimeContents.text != "시간을 선택하세요" {
            startTimeContents.textColor = .black
            startTimeIsBlack = true
        } else {
            startTimeContents.textColor = .gray80
        }
        
        if placeIsBlack && startTimeIsBlack {
            completedBtn.isEnabled = true
            completedBtn.backgroundColor = .green100
        } else {
            completedBtn.isEnabled = false
            completedBtn.backgroundColor = .green10
        }
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
    
    private func configureInitialSchedule(day: String, travel: Travel) -> String {
        guard let daysCount = Int(day) else {
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
    
    @objc func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        self.bindingDays()
        self.checkBlackText()
    }
    
    @objc func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        self.bindingTime()
        self.checkBlackText()
    }
    
    @IBAction func tappedPlaceBtn(_ sender: UIButton) {
        // TODO: - 장소 검색 화면으로 이동 구현 예정
    }
    
    @IBAction func tappedCompletedBtn(_ sender: UIButton) {
        realmManager.createSchedule(day: day!, date: selectedTime!, travel: travel!, placeDetail: placeDetail!, memo: memoTV.text)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedExitBtn(_ sender: UIButton) {
        configureBackAlert()
    }
}

// MARK: - extensions
extension PlanScheduleAddPlaceViewController: UIPopoverPresentationControllerDelegate {
    @IBAction func tappedScheduleBtn(_ sender: UIButton) {
        configurePopover(for: dayPopoverVC, sourceButton: scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        dayPopoverVC.day = day
        dayPopoverVC.travel = travel
        present(dayPopoverVC, animated: true)
    }
    
    @IBAction func tappedStartTimeBtn(_ sender: UIButton) {
        configurePopover(for: timePopoverVC, sourceButton: startTimeBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
}

extension PlanScheduleAddPlaceViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "메모를 입력해주세요" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모를 입력해주세요"
            textView.textColor = .gray80
        }
    }
}
