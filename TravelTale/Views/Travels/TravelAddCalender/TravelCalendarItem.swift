//
//  TravelCalendarItem.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/13/24.
//

import UIKit

import HorizonCalendar

// MARK: - protocol
protocol CalendarBaseView: BaseView {
    
    var calendar: Calendar { get }
    var monthsLayout: MonthsLayout { get }
    var dayDateFormatter: DateFormatter { get }
    var selectedDayRange: DayComponentsRange? { get }
    func makeContent() -> CalendarViewContent
}

// MARK: - DayRangeIndicatorView
// 선택된 날짜 범위 커스텀 뷰
final class DayRangeIndicatorView: BaseView {
    
    private let indicatorColor: UIColor
    
    init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        var dayRowFrames = [CGRect]()
        
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        for dayRowFrame in dayRowFrames {
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 12)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
}

//MARK: - DayLabel
// 일 UI커스텀
struct DayLabel: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
    }
    
    struct Content: Equatable {
        let day: DayComponents
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        label.backgroundColor = invariantViewProperties.backgroundColor
        
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        
        return label
    }
    
    static func setContent(_ content: Content, on view: UILabel) {
        view.text = "\(content.day.day)"
        
    }
}

//MARK: - MonthLabel
// 월 UI커스텀
struct MonthLabel: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        let textColor: UIColor
    }
    
    struct Content: Equatable {
        let month: MonthComponents
        let year: Int
        
        init(month: MonthComponents) {
            self.month = month
            self.year = month.year
        }
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        
        label.textAlignment = .left
        
        return label
    }
    
    static func setContent(_ content: Content, on view: UILabel) {
        view.text = "\(content.year)년 \(content.month.month)월"
    }
}

//MARK: - MonthDayLabel
// 요일 UI커스텀
struct MonthDayLabel: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        let textColor: UIColor
    }
    
    struct Content: Equatable{
        let dayOfWeek: DayOfWeek
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        
        label.textAlignment = .center
        
        return label
    }
    
    static func setContent(_ content: Content, on view: UILabel) {
        view.text = content.dayOfWeek.text
        
    }
}

// MARK: - enum
// MARK: - DayOfWeek
// 요일 UI 커스텀(한국어로)
enum DayOfWeek: Int {
    case sun = 0
    case mon
    case tue
    case wed
    case thr
    case fri
    case sat
    
    var text: String {
        switch self {
        case .sun: return "일"
        case .mon: return "월"
        case .tue: return "화"
        case .wed: return "수"
        case .thr: return "목"
        case .fri: return "금"
        case .sat: return "토"
        }
    }
}

// MARK: - DayRangeSelectionHelper
// 날짜 선택 범위 핸들러 기능
enum DayRangeSelectionHelper {
    
    static func updateDayRange(
        afterTapSelectionOf day: DayComponents,
        existingDayRange: inout DayComponentsRange?)
    {
        if let currentDayRange = existingDayRange,
           currentDayRange.lowerBound == currentDayRange.upperBound,
            day > currentDayRange.lowerBound
        {
            existingDayRange = currentDayRange.lowerBound...day
        } else {
            existingDayRange = day...day
        }
    }
}

// MARK: - extension
// MARK: - DayRangeIndicatorView
// 선택된 날짜 범위 커스텀
extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let indicatorColor = UIColor.green10
    }
    
    struct Content: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayRangeIndicatorView
    {
        DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
    }
    
    static func setContent(_ content: Content, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
    }
}

// MARK: - CalendarBaseView
// 캘린더 뷰를 커스텀
extension CalendarBaseView {
    func makeContent() -> CalendarViewContent {
        let startDate = calendar.date(byAdding: .month, value: 0, to: Date())!
        let endDate = calendar.date(byAdding: .year, value: 3, to: Date())!
        
        let dateRanges: Set<ClosedRange<Date>>
        let selectedDayRange = selectedDayRange
        if let selectedDayRange,
           let lowerBound = calendar.date(from: selectedDayRange.lowerBound.components),
           let upperBound = calendar.date(from: selectedDayRange.upperBound.components) {
            dateRanges = [lowerBound...upperBound]
        } else {
            dateRanges = []
        }
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: monthsLayout)
        
        .interMonthSpacing(24)
        .verticalDayMargin(8)
        .horizontalDayMargin(8)
        
        .dayItemProvider { [calendar, dayDateFormatter] day in
            var invariantViewProperties = DayView.InvariantViewProperties.baseInteractive
            
            let isSelectedStyle: Bool
            if let selectedDayRange {
                isSelectedStyle = 
                day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
            } else {
                isSelectedStyle = false
            }
            
            if isSelectedStyle {
                invariantViewProperties.textColor = .white
                invariantViewProperties.font = .pretendard(size: 15, weight: .bold)
                invariantViewProperties.shape = Shape.rectangle(cornerRadius: 6)
                invariantViewProperties.backgroundShapeDrawingConfig = .init(fillColor: .green100)
            } else {
                invariantViewProperties.textColor = .gray90
                invariantViewProperties.font = .pretendard(size: 15, weight: .medium)
            }
            
            let date = calendar.date(from: day.components)
            
            return DayView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                content: .init(
                    dayText: "\(day.day)",
                    accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
                    accessibilityHint: nil))
        }
        
        .monthHeaderItemProvider { month in
            MonthLabel.calendarItemModel(
                invariantViewProperties: .init(
                    font: .pretendard(size: 16, weight: .bold),
                    textColor: .blueBlack100),
                content: .init(month: month))
        }
        
        .dayOfWeekItemProvider{ month, weekdayIndex in
            let dayOfWeek = DayOfWeek(rawValue: weekdayIndex) ?? .sun
            return MonthDayLabel.calendarItemModel(
                invariantViewProperties: .init(
                    font: .pretendard(size: 15, weight: .medium),
                    textColor: .gray70),
                content: .init(dayOfWeek: dayOfWeek)
            )
        }
        
        .dayRangeItemProvider(for: dateRanges) { dayRangeLayoutContext in
            let framesOfDaysToHighlight = dayRangeLayoutContext.daysAndFrames.map { $0.frame }
            return DayRangeIndicatorView.calendarItemModel(
                invariantViewProperties: .init(),
                content: .init(framesOfDaysToHighlight: framesOfDaysToHighlight)
            )
        }
    }
}
