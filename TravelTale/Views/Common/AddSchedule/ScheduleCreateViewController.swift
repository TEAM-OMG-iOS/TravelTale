//
//  TravelAddViewController2.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit

final class ScheduleCreateViewController: BaseViewController {
    
    // MARK: - properties
    private let scheduleCreateView = ScheduleCreateView()
    
    private let dayPopoverVC = DaySelectPopoverViewController()
    
    private let timePopoverVC = TimeSelectPopoverViewController()
    
    // TODO: 데이터 모델에 따라 변경될 예정
    var selectedData: Travel? = nil
    
    var selectedDays: String?
    
    var selectedTime: Date?
    
    // MARK: - life cycles
    override func loadView() {
        view = scheduleCreateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleCreateView.checkBlackText()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedDays), name: .selectedDaysUpdated, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scheduleCreateView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        scheduleCreateView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        //popoverview
        scheduleCreateView.scheduleBtn.addTarget(self, action: #selector(tappedScheduleBtn), for: .touchUpInside)
        scheduleCreateView.startTiemBtn.addTarget(self, action: #selector(tappedStartTimeBtn), for: .touchUpInside)
        
        //common btn
        scheduleCreateView.cancelBtn.tag = 0
        scheduleCreateView.cancelBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        scheduleCreateView.backButton.tag = 1
        scheduleCreateView.backButton.target = self
        scheduleCreateView.backButton.action = #selector(handleBackButton)
        scheduleCreateView.nextBtn.addTarget(self, action: #selector(tappedAddScheduleBtn), for: .touchUpInside)
    }
    
    override func bind() {
        // TODO: - 추후 장소 데이터 바인딩 추가 예정
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = scheduleCreateView.backButton
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }
    
    private func bindingDays() {
        scheduleCreateView.scheduleContents.text = selectedDays
    }
    
    private func bindingTime() {
        scheduleCreateView.startTimeContents.text = dateFormat(date: selectedTime ?? Date())
    }
    
    func configurePopover(for popoverVC: UIViewController, sourceButton: UIButton) {
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 300, height: 200)
        let popoverPresentationController = popoverVC.popoverPresentationController
        popoverPresentationController?.sourceView = sourceButton
        popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(x: sourceButton.bounds.maxX - 50, y: sourceButton.bounds.midY + 10), size: .zero)
        popoverPresentationController?.permittedArrowDirections = .up
    }
    
    // MARK: - objc func
    @objc private func handleBackButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            navigationController?.popViewController(animated: true)
        default:
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        self.bindingDays()
        self.scheduleCreateView.checkBlackText()
    }
    
    @objc func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        self.bindingTime()
        self.scheduleCreateView.checkBlackText()
    }
    
    @objc func tappedAddScheduleBtn() {
        // TODO: - 페이지 플로우 확인 후 이동, 저장 로직 수정 예정
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - extensions
extension ScheduleCreateViewController: UIPopoverPresentationControllerDelegate {
    @objc private func tappedScheduleBtn() {
        configurePopover(for: dayPopoverVC, sourceButton: scheduleCreateView.scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        present(dayPopoverVC, animated: true)
    }
    
    @objc private func tappedStartTimeBtn() {
        configurePopover(for: timePopoverVC, sourceButton: scheduleCreateView.startTiemBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension ScheduleCreateViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scheduleCreateView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scheduleCreateView.setEndText(textView: textView)
    }
}
