//
//  TravelAddCalendarBaseView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/19/24.
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
            return TravelAddCalendarDayRangeIndicatorView.calendarItemModel(
                invariantViewProperties: .init(),
                content: .init(framesOfDaysToHighlight: framesOfDaysToHighlight)
            )
        }
    }
}
