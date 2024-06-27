//
//  PlanScheduleAddEditPlaceView.swift
//  TravelTale
//
//  Created by Kinam on 6/27/24.
//

import UIKit

class PlanScheduleAddEditPlaceView: BaseView {
    
    // MARK: - properties
    let alertMessage = """
이전으로 돌아가면 작성 내용이 저장되지 않습니다.
정말 돌아가시겠습니까?
"""
    let addVCNaviLabel = "장소 추가"
    
    let editVCNaviLabel = "장소 수정"
    
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "chevron.left")
        $0.tintColor = .gray90
    }
    
    private let placeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let placeBtn = UIButton().then {
        $0.configureView(color: .clear)
    }
    
    private let placeTitle = UILabel().then {
        $0.configureLabel(font: .pretendard(size: 16, weight: .bold), text: "장소")
    }
    
    let placeContents = UILabel().then {
        $0.configureLabel(color: .gray80 ,font: .pretendard(size: 16, weight: .regular), text: "어디로")
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
        $0.configureLabel(color: .black, font: .pretendard(size: 16, weight: .regular), text: "일정을 선택하세요")
    }
    
    private let startTimeView = UIView().then {
        $0.configureView(color: .gray5, cornerRadius: 20)
    }
    
    let startTimeBtn = UIButton().then {
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
    
    let completedBtn = GreenButton().then {
        $0.configureButton(fontColor: .white, font: .pretendard(size: 18, weight: .semibold), text: "완료")
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        [placeView, scheduleView, startTimeView, memoView ,completedBtn].forEach {
            self.addSubview($0)
        }
        
        [placeBtn, placeTitle, placeContents].forEach {
            self.placeView.addSubview($0)
        }
        
        [scheduleBtn, scheduleTitle, scheduleContents].forEach {
            self.scheduleView.addSubview($0)
        }
        
        [startTimeBtn ,startTimeTitle, startTimeContents].forEach {
            self.startTimeView.addSubview($0)
        }
        
        [memoTitle, memoTV].forEach {
            self.memoView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        placeView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
        
        placeBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        
        startTimeBtn.snp.makeConstraints {
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
            $0.bottom.greaterThanOrEqualTo(completedBtn.snp.top).offset(-80)
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
        
        completedBtn.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(52)
        }
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
        var placeIsBlack = false
        var scheduleIsBlack = false
        var startTimeIsBlack = false
        
        if placeContents.text != "어디로" {
            placeContents.textColor = .black
            placeIsBlack = true
        } else {
            placeContents.textColor = .gray80
        }
        
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
        
        if scheduleIsBlack && startTimeIsBlack && placeIsBlack {
            completedBtn.isEnabled = true
            completedBtn.backgroundColor = .green100
        } else {
            completedBtn.isEnabled = false
            completedBtn.backgroundColor = .green10
        }
    }
    
    func checkMemo(textColor: UIColor) -> String {
        return textColor == .gray80 ? "" : memoTV.text
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        return formatter.string(from: date)
    }
    
    func configureInitialSchedule(selectedDay: String, alldays: String, travel: Travel) -> String {
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
    
    func configureInitialStartTimeContents(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm"
        let dateString = formatter.string(from: date)
        return dateString
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
    
    func extractDayNumber(from formattedString: String) -> String? {
        let components = formattedString.split(separator: " ")
        if components.count > 1 {
            let dayNumber = String(components[1])
            return dayNumber
        }
        return ""
    }
}
