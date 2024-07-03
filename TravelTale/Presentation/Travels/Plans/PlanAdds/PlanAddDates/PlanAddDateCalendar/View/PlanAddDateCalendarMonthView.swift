//
//  PlanAddDateCalendarMonthView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/19/24.
//

import UIKit
import HorizonCalendar

// 월 UI커스텀
struct PlanAddDateCalendarMonthView: CalendarItemViewRepresentable {
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
