//
//  TravelViewModel.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import UIKit

final class TravelViewModel {
    
    // MARK: - properties
    // input
    var travelArray: Observable<[Travel]> = .init([])
    
    var upcomingTravels: [Travel] = []
    var pastTravels: [Travel] = []
    
    
    // MARK: - methods
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
