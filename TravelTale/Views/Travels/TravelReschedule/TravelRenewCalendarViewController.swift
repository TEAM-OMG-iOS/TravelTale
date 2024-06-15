//
//  TravelRenewCalendarViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/12/24.
//

import UIKit
import HorizonCalendar

final class TravelRenewCalendarViewController: BaseViewController, CalendarViewController {
    
    // MARK: - properties
    private let travelRenewCalendarView = TravelRenewCalendarView()
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
    
    // MARK: - lifecycle
    override func loadView() {
        view = travelRenewCalendarView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionHandler()
        configureConstraints()
        
        travelRenewCalendarView.okButton.isEnabled = false
        travelRenewCalendarView.okButton.setTitle("2박 3일", for: .normal)
    }
    
    required init(monthsLayout: MonthsLayout) {
        self.monthsLayout = monthsLayout
        super.init(nibName: nil, bundle: nil)
        
        selectedDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 19))!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    override func configureAddTarget() {
    }
    
    private func configureConstraints() {
        view.addSubview(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(travelRenewCalendarView.inputTitleLabel.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(travelRenewCalendarView.okButton.snp.top).offset(-12)
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
            
            if startDate == endDate {
                travelRenewCalendarView.okButton.isEnabled = true
                travelRenewCalendarView.okButton.backgroundColor = .green100
                travelRenewCalendarView.okButton.setTitle("당일치기", for: .normal)
                completion?("당일치기")
                
            } else {
                if let days = calendar.dateComponents([.day], from: startDate, to: endDate).day {
                    let n = days + 1
                    travelRenewCalendarView.okButton.setTitle("\(n-1)박 \(n)일", for: .normal)
                    
                    completion?("\(n-1)박 \(n)일")
                }
            }
        }
    }
}
