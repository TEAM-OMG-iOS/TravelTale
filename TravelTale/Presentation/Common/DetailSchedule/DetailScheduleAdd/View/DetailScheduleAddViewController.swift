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
    private let timePopoverVC = PopoverTimeViewController()
    private let realmManager = RealmManager.shared
    private let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
계속 진행하시겠습니까?
"""
    
    private lazy var dayPopoverVC = PopoverDayViewController(data: configureData(day: day, travel: selectedTravel), travel: selectedTravel)
    
    private var day: String
    private var selectedTravel: Travel
    private var selectedPlace: PlaceDetail
    
    var selectedDays: String?
    var selectedTime: Date?
    
    // MARK: - life cycles
    init(day: String, selectedTravel: Travel, selectedPlace: PlaceDetail) {
        self.day = day
        self.selectedTravel = selectedTravel
        self.selectedPlace = selectedPlace
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        detailScheduleAddView.placeContents.text = selectedPlace.title
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
        let alert = UIAlertController(title: "경고", message: alertMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .destructive) {_ in
            let nextVC = PlaceDetailViewController()
            // TODO: - 데이터 전달
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func configureData(day: String, travel: Travel) -> [String] {
        guard let daysCount = Int(day) else {
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
        realmManager.createSchedule(day: selectedDays!, date: selectedTime!, travel: selectedTravel, placeDetail: selectedPlace)
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
