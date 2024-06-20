//
//  Bookmark.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    @Persisted(primaryKey: true) var contentId: String
    @Persisted var contentTypeId: String?
    @Persisted var image: Data?
    @Persisted var title: String?
    @Persisted var address: String?
}
