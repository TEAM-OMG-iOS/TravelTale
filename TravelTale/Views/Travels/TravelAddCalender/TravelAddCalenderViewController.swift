//
//  TravelAddCalenderViewController.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

class TravelAddCalenderViewController: BaseViewController, CalendarViewController {
    
    // MARK: - properties
    private let travelAddCalenderView = TravelAddCalenderView()
    lazy var calendarView = CalendarView(initialContent: makeContent())
    
    lazy var calendar = Calendar.current
    let monthsLayout: MonthsLayout
    
    private var selectedDate: Date?
    var selectedDayRange: DayComponentsRange?
    private var selectedDayRangeAtStartOfDrag: DayComponentsRange?
    
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
        view = travelAddCalenderView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        travelAddCalenderView.startLoadingAnimation()
    }
    
    private func configureConstraints() {
        view.addSubview(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(travelAddCalenderView.endLabel.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(travelAddCalenderView.okButton.snp.top).offset(-12)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionHandler()
        configureConstraints()
        
        travelAddCalenderView.okButton.isEnabled = false
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
    override func configureStyle() {
        configureNavigationBarItems()
    }
    
    override func configureAddTarget() {
        travelAddCalenderView.cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        travelAddCalenderView.okButton.addTarget(self, action: #selector(tappedToRootView), for: .touchUpInside)
        travelAddCalenderView.backButton.target = self
        travelAddCalenderView.backButton.action = #selector(tappedToRootView)
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
            travelAddCalenderView.setStartDate(startDate)
            travelAddCalenderView.setEndDate(endDate)
            
            if startDate == endDate {
                travelAddCalenderView.okButton.isEnabled = true
                travelAddCalenderView.okButton.backgroundColor = .green100
                travelAddCalenderView.okButton.setTitle("당일치기", for: .normal)
            } else {
                
                if let days = calendar.dateComponents([.day], from: startDate, to: endDate).day {
                    let n = days + 1
                    travelAddCalenderView.okButton.setTitle("\(n-1)박 \(n)일", for: .normal)
                }
            }
        }
    }
    
    private func configureNavigationBarItems() {
        navigationItem.title = "새 여행 추가"
        navigationItem.leftBarButtonItem = travelAddCalenderView.backButton
    }
    
    @objc func tappedCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func tappedToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
