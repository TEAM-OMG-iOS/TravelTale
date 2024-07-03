//
//  PlanDetailAnnotation.swift
//  TravelTale
//
//  Created by 김정호 on 7/1/24.
//

import UIKit
import MapKit

final class PlanDetailAnnotation: NSObject, MKAnnotation {
    
    // MARK: - properties
    var coordinate: CLLocationCoordinate2D
    var index: Int
    
    // MARK: - life cycles
    init(coordinate: CLLocationCoordinate2D, index: Int) {
        self.coordinate = coordinate
        self.index = index
    }
}
