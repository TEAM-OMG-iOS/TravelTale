//
//  RealmManager.swift
//  TravelTale
//
//  Created by 김정호 on 6/16/24.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    // MARK: - properties
    static let shared = RealmManager()
    private init() { self.realm = try! Realm() }
    
    private let realm: Realm
    
    // MARK: - methods
    func createTravel(title: String, area: String, startDate: Date, endDate: Date) {
        let travel = Travel()
        travel.title = title
        travel.area = area
        travel.startDate = startDate
        travel.endDate = endDate
        
        do {
            try realm.write {
                realm.add(travel)
            }
        } catch {
            print("createTravel 실패")
        }
    }
    
    func fetchTravels() -> [Travel] {
        return realm.objects(Travel.self).sorted { lhs, rhs in
            if lhs.startDate != rhs.startDate {
                return lhs.startDate < rhs.startDate
            } else {
                return lhs.endDate < rhs.endDate
            }
        }
    }
    
    func updateTravel(travel: Travel, title: String, area: String, startDate: Date, endDate: Date) {
        do {
            try realm.write {
                if travel.title != title {
                    travel.title = title
                }
                
                if travel.area != area {
                    travel.area = area
                }
                
                if travel.startDate != startDate {
                    travel.startDate = startDate
                }
                
                if travel.endDate != endDate {
                    travel.endDate = endDate
                }
            }
        } catch {
            print("updateTravel 실패")
        }
    }
    
    func deleteTravel(travel: Travel) {
        do {
            try realm.write {
                realm.delete(travel)
            }
        } catch {
            print("deleteTravel 실패")
        }
    }
    
    func createMemory(travel: Travel, memory: String? = nil, photos: [Data]? = nil) {
        do {
            try realm.write {
                if let memory {
                    travel.memory = memory
                }
                
                if let photos {
                    travel.photos.append(objectsIn: photos)
                }
            }
        } catch {
            print("createMemory 실패")
        }
    }
    
    func fetchMemories() -> [Travel] {
        return realm.objects(Travel.self).filter { $0.memory != nil }
    }
    
    func updateMemory(travel: Travel, memory: String? = nil, photos: [Data]? = nil) {
        do {
            try realm.write {
                if let memory {
                    travel.memory = memory
                }
                
                if let photos {
                    travel.photos.removeAll()
                    travel.photos.append(objectsIn: photos)
                }
            }
        } catch {
            print("updateMemory 실패")
        }
    }
    
    func deleteMemory(travel: Travel) {
        do {
            try realm.write {
                travel.memory = nil
                travel.photos.removeAll()
            }
        } catch {
            print("deleteMemory 실패")
        }
    }
    
    func createSchedule(day: String, date: Date, travel: Travel, placeDetail: PlaceDetail, memo: String? = nil) {
        do {
            try realm.write {
                let schedule = Schedule()
                schedule.day = day
                schedule.title = placeDetail.title ?? "제목 없음"
                schedule.date = date
                schedule.internalMemo = memo
                schedule.mapX = placeDetail.mapx
                schedule.mapY = placeDetail.mapy
                
                if let addr1 = placeDetail.addr1 {
                    if let addr2 = placeDetail.addr2 {
                        schedule.address = addr1 + addr2
                    } else {
                        schedule.address = addr1
                    }
                }
                
                travel.schedules.append(schedule)
            }
        } catch {
            print("createSchedule 실패")
        }
    }
    
    func updateSchedule(schedule: Schedule, placeDetail: PlaceDetail? = nil, day: String? = nil, date: Date? = nil, internalMemo: String? = nil) {
        do {
            try realm.write {
                if let placeDetail {
                    if schedule.title != placeDetail.title {
                        schedule.title = placeDetail.title
                        schedule.mapX = placeDetail.mapx
                        schedule.mapY = placeDetail.mapy
                        
                        if let addr1 = placeDetail.addr1 {
                            if let addr2 = placeDetail.addr2 {
                                schedule.address = addr1 + addr2
                            } else {
                                schedule.address = addr1
                            }
                        }
                    }
                }
                
                if schedule.day != day {
                    schedule.day = day
                    schedule.date = date
                }
                
                if schedule.date != date {
                    schedule.date = date
                }
                
                if schedule.internalMemo != internalMemo {
                    schedule.internalMemo = internalMemo
                }
            }
        } catch {
            print("updateSchedule 실패")
        }
    }
    
    func deleteSchedule(travel: Travel, schedule: Schedule) {
        do {
            try realm.write {
                if let index = travel.schedules.firstIndex(of: schedule) {
                    travel.schedules.remove(at: index)
                }
                
                realm.delete(schedule)
            }
        } catch {
            print("deleteSchedule 실패")
        }
    }
    
    func createMemo(day: String, travel: Travel, memo: String) {
        do {
            try realm.write {
                let schedule = Schedule()
                schedule.day = day
                schedule.date = Date()
                schedule.externalMemo = memo
                
                travel.schedules.append(schedule)
            }
        } catch {
            print("createMemo 실패")
        }
    }
    
    func updateMemo(schedule: Schedule, newMemo: String) {
        do {
            try realm.write {
                if schedule.externalMemo != newMemo {
                    schedule.externalMemo = newMemo
                }
            }
        } catch {
            print("updateMemo 실패")
        }
    }
    
    func deleteMemo(travel: Travel, schedule: Schedule) {
        do {
            try realm.write {
                if let index = travel.schedules.firstIndex(of: schedule) {
                    travel.schedules.remove(at: index)
                }
                
                realm.delete(schedule)
            }
        } catch {
            print("deleteMemo 실패")
        }
    }
    
    func createBookmark(placeDetail: PlaceDetail, imageData: Data?) {
        do {
            try realm.write {
                let bookmark = Bookmark()
                bookmark.contentId = placeDetail.contentId ?? "-1"
                bookmark.contentTypeId = placeDetail.contentTypeId
                bookmark.title = placeDetail.title
                bookmark.image = imageData
                
                if let addr1 = placeDetail.addr1 {
                    if let addr2 = placeDetail.addr2 {
                        bookmark.address = addr1 + addr2
                    } else {
                        bookmark.address = addr1
                    }
                }
                
                realm.add(bookmark)
            }
        } catch {
            print("createBookmark 실패")
        }
    }
    
    func fetchBookmarks(contentTypeId: Category) -> [Bookmark] {
        if contentTypeId == .total {
            return Array(realm.objects(Bookmark.self))
        } else {
            return Array(realm.objects(Bookmark.self)).filter { $0.contentTypeId == contentTypeId.rawValue }
        }
    }
    
    func deleteBookmark(placeDetail: PlaceDetail) {
        do {
            try realm.write {
                let bookmark = realm.objects(Bookmark.self).filter { $0.contentId == placeDetail.contentId }.first
                
                if let bookmark {
                    realm.delete(bookmark)
                }
            }
        } catch {
            print("deleteBookmark 실패")
        }
    }
    
    func deleteBookmark(bookmark: Bookmark) {
        do {
            try realm.write {
                realm.delete(bookmark)
            }
        } catch {
            print("deleteBookmark 실패")
        }
    }
}
