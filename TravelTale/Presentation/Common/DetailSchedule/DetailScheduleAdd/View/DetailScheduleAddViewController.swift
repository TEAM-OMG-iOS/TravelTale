//
//  DetailScheduleAddViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit

final class DetailScheduleAddViewController: BaseViewController {
    
    // MARK: - properties
    private let detailScheduleAddView = DetailScheduleAddView()
    private let dayPopoverVC = PopoverDayViewController()
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    private var day: String?
    
    var selectedTravel: Travel? {
        didSet {
            day = dayDifference(from: selectedTravel!.startDate, to: selectedTravel!.endDate)
        }
    }
    var selectedPlace: PlaceDetail?
    var selectedDays: String?
    var selectedTime: Date?
    
    // MARK: - life cycles
    override func loadView() {
        view = detailScheduleAddView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailScheduleAddView.checkBlackText()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedDays), name: .selectedDaysUpdated, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        detailScheduleAddView.startLoadingAnimation()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigationBar()
    }
    
    override func configureDelegate() {
        detailScheduleAddView.memoTV.delegate = self
    }
    
    override func configureAddTarget() {
        //popoverview
        detailScheduleAddView.scheduleBtn.addTarget(self, action: #selector(tappedScheduleBtn), for: .touchUpInside)
        detailScheduleAddView.startTiemBtn.addTarget(self, action: #selector(tappedStartTimeBtn), for: .touchUpInside)
        
        //common btn
        detailScheduleAddView.cancelBtn.tag = 0
        detailScheduleAddView.cancelBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        detailScheduleAddView.backButton.tag = 1
        detailScheduleAddView.backButton.target = self
        detailScheduleAddView.backButton.action = #selector(handleBackButton)
        detailScheduleAddView.nextBtn.addTarget(self, action: #selector(tappedAddScheduleBtn), for: .touchUpInside)
    }
    
    override func bind() {
        detailScheduleAddView.placeContents.text = selectedPlace?.title
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "내 여행에 추가"
        navigationItem.leftBarButtonItem = detailScheduleAddView.backButton
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }
    
    private func bindingDays() {
        detailScheduleAddView.scheduleContents.text = selectedDays
    }
    
    private func bindingTime() {
        detailScheduleAddView.startTimeContents.text = dateFormat(date: selectedTime ?? Date())
    }
    
    private func configurePopover(for popoverVC: UIViewController, sourceButton: UIButton) {
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 300, height: 200)
        let popoverPresentationController = popoverVC.popoverPresentationController
        popoverPresentationController?.sourceView = sourceButton
        popoverPresentationController?.sourceRect = CGRect(
            origin: CGPoint(x: sourceButton.bounds.maxX - 50, y: sourceButton.bounds.midY + 10), size: .zero)
        popoverPresentationController?.permittedArrowDirections = .up
    }
    
    private func configureBackAlert() {
        let alert = UIAlertController(title: "경고", message: """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
계속 진행하시겠습니까?
""", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {_ in
            let nextVC = PlaceDetailViewController()
            // TODO: - 데이터 전달
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func dayDifference(from startDate: Date, to endDate: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        if let dayDifference = components.day {
            return String(dayDifference)
        } else {
            return "0"
        }
    }
    
    @objc private func handleBackButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            navigationController?.popViewController(animated: true)
        default:
            configureBackAlert()
        }
    }
    
    @objc private func updateSelectedDays(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedDays = userInfo["selectedDays"] as? String else { return }
        
        self.selectedDays = selectedDays
        self.bindingDays()
        self.detailScheduleAddView.checkBlackText()
    }
    
    @objc private func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        self.bindingTime()
        self.detailScheduleAddView.checkBlackText()
    }
    
    @objc private func tappedAddScheduleBtn() {
        realmManager.createSchedule(day: selectedDays!, date: selectedTime!, travel: selectedTravel!, placeDetail: selectedPlace!)
        let alert = UIAlertController(title: "일정 추가 완료", message: "일정 추가가 완료되었습니다.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        let nextVC = PlaceDetailViewController()
        // TODO: - 데이터 전달
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        self.present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - extensions
extension DetailScheduleAddViewController: UIPopoverPresentationControllerDelegate {
    @objc private func tappedScheduleBtn() {
        configurePopover(for: dayPopoverVC, sourceButton: detailScheduleAddView.scheduleBtn)
        dayPopoverVC.popoverPresentationController?.delegate = self
        dayPopoverVC.day = day
        dayPopoverVC.travel = selectedTravel
        present(dayPopoverVC, animated: true)
    }
    
    @objc private func tappedStartTimeBtn() {
        configurePopover(for: timePopoverVC, sourceButton: detailScheduleAddView.startTiemBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

extension DetailScheduleAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        detailScheduleAddView.setBeginText(textView: textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        detailScheduleAddView.setEndText(textView: textView)
    }
}
