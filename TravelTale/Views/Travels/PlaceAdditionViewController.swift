//
//  PlaceAdditionViewController.swift
//  TravelTale
//
//  Created by Kinam on 6/5/24.
//

import UIKit

class PlaceAdditionViewController: BaseViewController {
    
    // MARK: - properties
    @IBOutlet weak var placeContents: UILabel!
    @IBOutlet weak var startTimeContents: UILabel!
    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var memoTV: UITextView!
    @IBOutlet weak var scheduleContents: UILabel!
    @IBOutlet weak var naviTitle: UINavigationItem!
    @IBOutlet weak var completedBtn: UIButton!
    
    private let timePopoverVC = TimeSelectPopoverViewController()
    
    var selectedTime: Date?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedTime), name: .selectedTimeUpdated, object: nil)
        checkBlackText()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        memoTV.delegate = self
    }
    
    override func bind() {
        // TODO: - 일정 데이터 추가 시 수정 예정
    }
    
    private func setBeginText(textView: UITextView) {
        if textView.text == "메모를 입력해주세요" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    private func setEndText(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모를 입력해주세요"
            textView.textColor = .gray80
        }
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
    
    private func checkBlackText() {
        var scheduleIsBlack = false
        var startTimeIsBlack = false
        
        if placeContents.text != "어디로" {
            placeContents.textColor = .black
            scheduleIsBlack = true
        } else {
            placeContents.textColor = .gray80
        }
        
        if startTimeContents.text != "시간을 선택하세요" {
            startTimeContents.textColor = .black
            startTimeIsBlack = true
        } else {
            startTimeContents.textColor = .gray80
        }
        
        if scheduleIsBlack && startTimeIsBlack {
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
    
    private func bindingTime() {
        startTimeContents.text = dateFormat(date: selectedTime ?? Date())
    }
    
    @objc private func updateSelectedTime(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let selectedTime = userInfo["selectedTime"] as? Date else { return }
        
        self.selectedTime = selectedTime
        self.bindingTime()
        self.checkBlackText()
    }
    
    @IBAction func tappedPlaceBtn(_ sender: UIButton) {
        // TODO: - 장소 검색 화면으로 이동 구현 예정
        print("move")
    }
    
    @IBAction func tappedCompletedBtn(_ sender: UIButton) {
        print("close")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedExitBtn(_ sender: UIButton) {
        print("close")
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - extensions
extension PlaceAdditionViewController: UIPopoverPresentationControllerDelegate {
    @IBAction func tappedStartTimeBtn(_ sender: UIButton) {
        configurePopover(for: timePopoverVC, sourceButton: startTimeBtn)
        timePopoverVC.popoverPresentationController?.delegate = self
        present(timePopoverVC, animated: true)
    }
}

extension PlaceAdditionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setBeginText(textView: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        setEndText(textView: textView)
    }
}
