//
//  PlaceDetail.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation

struct PlaceDetail {
    let contentId: String?
    let contentTypeId: String?
    let title: String?
    let tel: String?
    let homepage: String?
    let firstImage: String?
    let firstImage2: String?
    let cpyrhtDivCd: String?
    let addr1: String?
    let addr2: String?
    let mapx: String?
    let mapy: String?
    let overview: String?
}

struct PlaceDetails {
    let placeDetails: [PlaceDetail]?
}
