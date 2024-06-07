//
//  TravelViewModel.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import Foundation

class TravelViewModel {
    var travelArray: Observable<[Travel]> = .init([])
    
    func returnPeriodString(startDate: Date, endDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        return "\(startDateString) ~ \(endDateString)"
    }
}
