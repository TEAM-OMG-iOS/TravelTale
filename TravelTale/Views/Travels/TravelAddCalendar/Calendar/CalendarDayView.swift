//
//  CalendarDayView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/19/24.
//

import UIKit
import HorizonCalendar

// 일 UI커스텀
struct CalendarDayView: CalendarItemViewRepresentable {
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
