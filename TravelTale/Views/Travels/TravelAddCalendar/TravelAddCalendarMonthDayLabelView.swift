//
//  TravelAddCalendarMonthDayLabelView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/19/24.
//

import UIKit

import HorizonCalendar

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
