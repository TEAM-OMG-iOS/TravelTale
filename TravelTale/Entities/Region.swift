//
//  Region.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation
import RealmSwift

class Region: Object {
    @Persisted var sido: String
    @Persisted var sidoCode: String
    @Persisted var sigungu: String
    @Persisted var sigunguCode: String
}
