//
//  Travel.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation
import RealmSwift

class Travel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var area: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var schedules = List<Schedule>()
    @Persisted var memory: String?
    @Persisted var photos = List<Data>()
}
