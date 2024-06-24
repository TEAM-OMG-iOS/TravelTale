//
//  PlanAddDateView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/5/24.
//

import UIKit
import HorizonCalendar

final class PlanAddDateView: BaseView, PlanAddDateCalendarBaseView {
    
    // MARK: - properties
    lazy var calendarView = CalendarView(initialContent: makeContent())
    
    lazy var calendar = Calendar.current
    let monthsLayout: MonthsLayout
    
    private var selectedDate: Date?
    var selectedDayRange: DayComponentsRange?
    private var selectedDayRangeAtStartOfDrag: DayComponentsRange?
    
    var startDate: Date?
    var endDate: Date?
    
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
    
    let backButton = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "xmark")
        $0.tintColor = .gray90
    }
    
    private let inputTitleLabel = UILabel().then {
        $0.configureLabel(color: .blueBlack100,
                          font: .pretendard(size: 18, weight: .semibold),
                          text: "여행 날짜를 선택해주세요")
    }
    
    let startLabel = UILabel().then {
        $0.configureLabel(color: .gray90,
                          font: .pretendard(size: 16, weight: .medium),
                          text: "출발일 |")
    }
    
    let endLabel = UILabel().then {
        $0.configureLabel(color: .gray90,
                          font: .pretendard(size: 16, weight: .medium),
                          text: "도착일 |")
    }
    
    let cancelButton = GrayButton().then {
        $0.configureButton(fontColor: .white,
                           font: UIFont.pretendard(size: 18, weight: .bold),
                           text: "이전")
    }
    
    let okButton = UIButton().then {
        $0.isEnabled = false
        $0.tintColor = .white
        $0.titleLabel?.font = .pretendard(size: 18, weight: .bold)
        $0.setTitle("날짜 선택하러 가기", for: .normal)
        $0.configureView(color: .green10,
                         cornerRadius: 24)
    }
    
    private let progressView = UIView().then {
        $0.configureView(color: .gray20,
                         clipsToBounds: true,
                         cornerRadius: 4)
    }
    
    private let loadingBar = UIView().then {
        $0.configureView(color: .green80,
                         clipsToBounds: true,
                         cornerRadius: 4)
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
         startLabel,
         endLabel,
         cancelButton,
         okButton,
         progressView,
         calendarView].forEach {
            self.addSubview($0)
        }
        
        progressView.addSubview(loadingBar)
    }
    
    override func configureConstraints() {
        progressView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(116)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(8)
        }
        
        loadingBar.snp.makeConstraints {
            $0.leading.top.height.equalToSuperview()
            $0.width.equalTo(progressView.snp.width).multipliedBy(0.66)
        }
        
        inputTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(20)
        }
        
        startLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(172)
            $0.height.equalTo(48)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(inputTitleLabel.snp.bottom).offset(12)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.width.equalTo(172)
            $0.height.equalTo(48)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(endLabel.snp.bottom).offset(52)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(okButton.snp.top).offset(-12)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(okButton.snp.leading).offset(-15)
            $0.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(52)
            $0.width.equalTo(cancelButton.snp.width).multipliedBy(2)
        }
    }
    
    func startLoadingAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0, animations: {
            self.loadingBar.transform = CGAffineTransform(scaleX: 3, y: 1)
        })
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
    }
    
    private func setDateLabel() {
        if let startDate = calendar.date(from: selectedDayRange?.lowerBound.components ?? DateComponents()),
           let endDate = calendar.date(from: selectedDayRange?.upperBound.components ?? DateComponents()) {
            self.startDate = startDate
            self.endDate = endDate
            setStartDate(startDate: startDate, endDate: endDate)
            
            if startDate == endDate {
                okButton.isEnabled = true
                okButton.backgroundColor = .green100
                okButton.setTitle("당일치기", for: .normal)
            } else {
                
                if let days = calendar.dateComponents([.day], from: startDate, to: endDate).day {
                    let n = days + 1
                    okButton.setTitle("\(n-1)박 \(n)일", for: .normal)
                }
            }
        }
    }
    
    private func setStartDate(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        startLabel.text = "출발일 | \(startDateString)"
        endLabel.text = "도착일 | \(endDateString)"
    }
}
