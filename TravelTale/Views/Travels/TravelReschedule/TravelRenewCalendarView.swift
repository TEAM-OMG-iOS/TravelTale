//
//  TravelRenewCalendarView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class TravelRenewCalendarView: BaseView, CalendarBaseView {
    
    // MARK: - properties
    lazy var calendarView = CalendarView(initialContent: makeContent())
    
    lazy var calendar = Calendar.current
    let monthsLayout: MonthsLayout
    
    private var selectedDate: Date?
    var selectedDayRange: DayComponentsRange?
    private var selectedDayRangeAtStartOfDrag: DayComponentsRange?
    
    var completion: ((String) -> Void)?
    var dateCompletion: ((String) -> Void)?
    
    lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.locale = calendar.locale
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 날짜를 선택해주세요")
    }
    
    let okButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 18, weight: .bold)
        $0.configureView(color: .green10,
                         cornerRadius: 24)
    }
    
    // MARK: - life cycles
    required init(monthsLayout: MonthsLayout) {
        self.monthsLayout = monthsLayout
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureUI() {
        super.configureUI()
        selectionHandler()
    }
    
    override func configureHierarchy() {
        [inputTitleLabel,
         okButton,
         calendarView].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(okButton.snp.top).offset(-12)
        }
    }
    
    private func selectionHandler() {
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self else { return }
            
            DayRangeSelectionHelper.updateDayRange(
                afterTapSelectionOf: day,
                existingDayRange: &selectedDayRange)
            
            selectedDate = calendar.date(from: day.components)
            self.setDateLabel()
            calendarView.setContent(makeContent())
        }
        
        calendarView.multiDaySelectionDragHandler = { [weak self, calendar] day, state in
            guard let self else { return }
            
            DayRangeSelectionHelper.updateDayRange(
                afterDragSelectionOf: day,
                existingDayRange: &selectedDayRange,
                initialDayRange: &selectedDayRangeAtStartOfDrag,
                state: state,
                calendar: calendar)
            
            self.setDateLabel()
            calendarView.setContent(makeContent())
        }
    }
    
    private func setDateLabel() {
        if let startDate = calendar.date(from: selectedDayRange?.lowerBound.components ?? DateComponents()),
           let endDate = calendar.date(from: selectedDayRange?.upperBound.components ?? DateComponents()) {
            setStartDate(startDate: startDate, endDate: endDate)
            
            if startDate == endDate {
                okButton.isEnabled = true
                okButton.backgroundColor = .green100
                okButton.setTitle("당일치기", for: .normal)
                completion?("당일치기")
                
            } else {
                if let days = calendar.dateComponents([.day], from: startDate, to: endDate).day {
                    let n = days + 1
                    okButton.setTitle("\(n-1)박 \(n)일", for: .normal)
                    
                    completion?("\(n-1)박 \(n)일")
                }
            }
        }
    }
    
    private func setStartDate(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        let dateRangeString = "\(startDateString) - \(endDateString)"
        dateCompletion?(dateRangeString)
    }
}
