//
//  TravelViewModel.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import Foundation

class TravelViewModel {
    var travelArray: Observable<[Travel]> = .init([])
    
    var upcomingTravels: [Travel] = []
    var pastTravels: [Travel] = []
    
    func returnPeriodString(startDate: Date, endDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        return "\(startDateString) ~ \(endDateString)"
    }
    
    func splitTravelArray() {
        let today = Date()
        
        for travel in travelArray.value {
            if travel.endDate >= today {
                upcomingTravels.append(travel)
            } else {
                pastTravels.append(travel)
            }
        }
    }
}
