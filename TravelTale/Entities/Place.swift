//
//  Place.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation

struct Place {
    let addr1: String?
    let addr2: String?
    let contentId: String?
    let contentTypeId: String?
    let firstImage: String?
    let title: String?
    let cpyrhtDivCd: String?
}

struct Places {
    let places: [Place]?
}
