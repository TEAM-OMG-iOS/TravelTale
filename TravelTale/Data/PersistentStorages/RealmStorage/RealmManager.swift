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
    func createRegion(sido: Sido, sigungu: Sigungu? = nil) {
        if let region = fetchRegion() {
            do {
                try realm.write {
                    realm.delete(region)
                }
            } catch {
                print("region 리셋 실패")
            }
        }
        
        let region = Region()
        
        if let name = sido.name, let code = sido.code {
            region.sido = name
            region.sidoCode = code
            
            if let sigungu {
                if let sigunguName = sigungu.name, let sigunguCode = sigungu.code {
                    region.sigungu = sigunguName
                    region.sigunguCode = sigunguCode
                }
            }
            
            do {
                try realm.write {
                    realm.add(region)
                }
            } catch {
                print("createRegion 실패")
            }
        }
    }
    
    func fetchRegion() -> Region? {
        return realm.objects(Region.self).first
    }
    
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
                return lhs.startDate > rhs.startDate
            } else {
                return lhs.endDate > rhs.endDate
            }
        }
    }
    
    func fetchTravelsWithEmptyMemoryAndPhotos() -> [Travel] {
        return realm.objects(Travel.self).filter { $0.memory == nil }.sorted { lhs, rhs in
            if lhs.startDate != rhs.startDate {
                return lhs.startDate > rhs.startDate
            } else {
                return lhs.endDate > rhs.endDate
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
            
            updateDateRange(travel: travel)
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
    
    func createMemory(travel: Travel, memory: String, photos: [Data]? = nil) {
        do {
            try realm.write {
                if !memory.isEmpty {
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
                if let memory, !memory.isEmpty {
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

// MARK: - extensions
extension RealmManager {
    private func updateDateRange(travel: Travel) {
        let startDate = travel.startDate
        let endDate = travel.endDate
        
        let calendar = Calendar.current
        
        let endDay = calendar.dateComponents([.day], from: endDate).day
        let startDay = calendar.dateComponents([.day], from: startDate).day
        
        for schedule in travel.schedules {
            if let day = schedule.day, let scheduleDay = Int(day), let endDay, let startDay {
                if scheduleDay > endDay - startDay + 1 {
                    deleteSchedule(travel: travel, schedule: schedule)
                } else {
                    if let oldDate = schedule.date {
                        let oldDateComponents = calendar.dateComponents([.hour, .minute, .second], from: oldDate)
                        var newDateComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
                        
                        newDateComponents.hour = oldDateComponents.hour
                        newDateComponents.minute = oldDateComponents.minute
                        newDateComponents.second = oldDateComponents.second
                        
                        if let newDateComponentsDay = newDateComponents.day, let day = Int(day) {
                            newDateComponents.day = newDateComponentsDay + day - 1
                        }

                        do {
                            try realm.write {
                                schedule.date = calendar.date(from: newDateComponents) ?? Date()
                            }
                        } catch {
                            print("updateDateRange 실패")
                        }
                    }
                }
            }
        }
    }
}
