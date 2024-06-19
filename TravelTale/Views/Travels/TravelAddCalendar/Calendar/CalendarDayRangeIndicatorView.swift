//
//  CalendarDayRangeIndicatorView.swift
//  TravelTale
//
//  Created by SAMSUNG on 6/19/24.
//

import UIKit

import HorizonCalendar

// 선택된 날짜 범위 커스텀 뷰
final class CalendarDayRangeIndicatorView: BaseView {
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

// MARK: - extension
extension CalendarDayRangeIndicatorView: CalendarItemViewRepresentable {
    struct InvariantViewProperties: Hashable {
        let indicatorColor = UIColor.green10
    }
    
    struct Content: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> CalendarDayRangeIndicatorView {
        CalendarDayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
    }
    
    static func setContent(_ content: Content, on view: CalendarDayRangeIndicatorView) {
        view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
    }
}

// MARK: - enum
// 날짜 선택 범위 핸들러 기능
enum DayRangeSelectionHelper {
    static func updateDayRange(
        afterTapSelectionOf day: DayComponents,
        existingDayRange: inout DayComponentsRange?) {
        if let currentDayRange = existingDayRange,
           currentDayRange.lowerBound == currentDayRange.upperBound,
           day > currentDayRange.lowerBound {
            existingDayRange = currentDayRange.lowerBound...day
        } else {
            existingDayRange = day...day
        }
    }
}
