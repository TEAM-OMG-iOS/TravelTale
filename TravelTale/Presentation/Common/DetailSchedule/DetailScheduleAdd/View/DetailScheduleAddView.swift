//
//  DetailScheduleAddView.swift
//  TravelTale
//
//  Created by Kinam on 6/6/24.
//

import UIKit

final class DetailScheduleAddView: BaseView {
    
    // MARK: - properties
    let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
계속 진행하시겠습니까?
"""
    
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let loadingBackBar = UIView().then {
        $0.configureView(color: .gray10, cornerRadius: 4)
    }
    
    private var loadingBar = UIView().then {
        $0.configureView(color: .green80, cornerRadius: 4)
    }
    
    private let viewLabel = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 18, weight: .semibold), text: "일정을 생성해주세요")
    }
    
    private let placeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let placeTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "장소")
    }
    
    let placeContents = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .regular), text: "")
    }
    
    private let scheduleView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let scheduleBtn = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let scheduleTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "일정")
    }
    
    let scheduleContents = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "일정을 선택하세요")
    }
    
    private let startTimeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let startTiemBtn = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let startTimeTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "시작 시간")
    }
    
    let startTimeContents = UILabel().then {
        $0.configureLabel(color: .gray80, font: .pretendard(size: 16, weight: .regular), text: "시간을 선택하세요")
    }
    
    private let memoView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    private let memoTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "메모")
    }
    
    let memoTV = UITextView().then {
        $0.text = "메모를 입력하세요"
        $0.textColor = .gray80
        $0.font = .pretendard(size: 16, weight: .regular)
        $0.textAlignment = .natural
        $0.backgroundColor = .clear
    }
    
    private let btnStackView = UIStackView().then {
        $0.configureView(color: .clear)
        $0.axis = .horizontal
        $0.spacing = 15
    }
    
    let cancelBtn = GrayButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "취소")
    }
    
    let nextBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "일정 생성하러 가기")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [loadingBackBar, viewLabel, placeView, scheduleView, startTimeView, memoView ,btnStackView].forEach {
            self.addSubview($0)
        }
        
        [loadingBar].forEach {
            self.loadingBackBar.addSubview($0)
        }
        
        [placeTitle, placeContents].forEach {
            self.placeView.addSubview($0)
        }
        
        [scheduleBtn, scheduleTitle, scheduleContents].forEach {
            self.scheduleView.addSubview($0)
        }
        
        [startTiemBtn ,startTimeTitle, startTimeContents].forEach {
            self.startTimeView.addSubview($0)
        }
        
        [memoTitle, memoTV].forEach {
            self.memoView.addSubview($0)
        }
        
        [cancelBtn, nextBtn].forEach {
            self.btnStackView.addArrangedSubview($0)
        }
    }
    
    override func configureConstraints() {
        loadingBackBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(18)
            $0.height.equalTo(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        viewLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBackBar.snp.bottom).offset(56)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        placeView.snp.makeConstraints {
            $0.top.equalTo(viewLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        placeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleView.snp.makeConstraints {
            $0.top.equalTo(placeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(placeView)
            $0.height.equalTo(placeView.snp.height)
        }
        
        scheduleBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scheduleTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        scheduleContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeView.snp.makeConstraints {
            $0.top.equalTo(scheduleView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(scheduleView)
            $0.height.equalTo(scheduleView.snp.height)
        }
        
        startTiemBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        startTimeTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        startTimeContents.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        memoView.snp.makeConstraints {
            $0.top.equalTo(startTimeView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(startTimeView)
            $0.bottom.greaterThanOrEqualTo(btnStackView.snp.top).offset(-20)
        }
        
        memoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        memoTV.snp.makeConstraints {
            $0.top.equalTo(memoTitle.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
        btnStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(25)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(110)
        }
        
        nextBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(228)
        }
    }
    
    func startLoadingAnimation() {
        self.loadingBar.snp.remakeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.centerY.equalToSuperview()
            let fullwidth = loadingBackBar.frame.size.width
            $0.width.equalTo(fullwidth)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func setBeginText(textView: UITextView) {
        if textView.textColor == .gray80 {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func setEndText(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = .gray80
        }
    }
    
    func checkBlackText() {
        var scheduleIsBlack = false
        var startTimeIsBlack = false
        
        if scheduleContents.text != "일정을 선택하세요" {
            scheduleContents.textColor = .black
            scheduleIsBlack = true
        } else {
            scheduleContents.textColor = .gray80
        }
        
        if startTimeContents.text != "시간을 선택하세요" {
            startTimeContents.textColor = .black
            startTimeIsBlack = true
        } else {
            startTimeContents.textColor = .gray80
        }
        
        if scheduleIsBlack && startTimeIsBlack {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .green100
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .green10
        }
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }
    
    func extractDayNumber(from formattedString: String) -> String {
        let components = formattedString.split(separator: " ")
        if components.count > 1 {
            let dayNumber = String(components[1])
            return dayNumber
        }
        return ""
    }
    
    func configureData(allDays: String, travel: Travel) -> [String] {
        guard let daysCount = Int(allDays) else {
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
    
    func checkMemo(textColor: UIColor) -> String {
        return textColor == .gray80 ? "" : memoTV.text
    }
    
    func combineDate(date: Date, withTimeFrom timeDate: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: timeDate)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year ?? 0
        combinedComponents.month = dateComponents.month ?? 0
        combinedComponents.day = dateComponents.day ?? 0
        combinedComponents.hour = timeComponents.hour ?? 0
        combinedComponents.minute = timeComponents.minute ?? 0
        combinedComponents.second = timeComponents.second ?? 0
        
        return calendar.date(from: combinedComponents) ?? Date()
    }
    
    func configureScheduleDate(selectedDay: String, alldays: String, travel: Travel) -> Date {
        guard let daysCount = Int(selectedDay), let totalDays = Int(alldays), daysCount > 0, daysCount <= totalDays else {
            return Date()
        }
        
        if let targetDate = Calendar.current.date(byAdding: .day, value: daysCount - 1, to: travel.startDate) {
            return targetDate
        } else {
            return Date()
        }
    }
}
