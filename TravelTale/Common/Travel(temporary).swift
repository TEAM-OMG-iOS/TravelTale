//
//  Travel.swift
//  TravelTale
//
//  Created by 유림 on 6/5/24.
//

import Foundation

struct Travel {
    var image: Data?
    var title: String
    var startDate: Date
    var endDate: Date
    var province: String?
    var memoryNote: String?
    var memoryImageDatas: [Data?] = []
}
