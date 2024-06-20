//
//  Schedule.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation
import RealmSwift

class Schedule: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var day: String?
    @Persisted var title: String?
    @Persisted var date: Date?
    @Persisted var address: String?
    @Persisted var internalMemo: String?
    @Persisted var externalMemo: String?
    @Persisted var mapX: String?
    @Persisted var mapY: String?
}
