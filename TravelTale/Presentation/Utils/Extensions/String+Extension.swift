//
//  String+Extension.swift
//  TravelTale
//
//  Created by 유림 on 6/19/24.
//

import Foundation

extension String {
    init(startDate: Date, endDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        if startDate == endDate {
            self = String(describing: startDateString)
        } else {
            self = "\(startDateString) ~ \(endDateString)"
        }
    }
}
