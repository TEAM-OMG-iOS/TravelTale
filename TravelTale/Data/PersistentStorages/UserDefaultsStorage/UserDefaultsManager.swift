//
//  UserDefaultsManager.swift
//  TravelTale
//
//  Created by 김정호 on 6/16/24.
//

import Foundation

enum TabType: String {
    case travel = "travel"
    case discovery = "discovery"
}

final class UserDefaultsManager {
    
    // MARK: - properties
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let keywordKey = "keyword"
    private let tabTypeKey = "tabType"
    
    // MARK: - methods
    func createKeyword(keyword: String) -> [String] {
        var keywords = fetchKeywords()
        
        if let index = keywords.firstIndex(of: keyword) {
            keywords.remove(at: index)
        }
        
        keywords.insert(keyword, at: 0)
        
        UserDefaults.standard.set(keywords, forKey: keywordKey)
        
        return fetchKeywords()
    }
    
    func fetchKeywords() -> [String] {
        if let keywords = UserDefaults.standard.array(forKey: keywordKey) as? [String] {
            return keywords
        } else {
            return []
        }
    }
    
    func deleteKeyword(keyword: String) -> [String] {
        var keywords = fetchKeywords()
        
        if let index = keywords.firstIndex(of: keyword) {
            keywords.remove(at: index)
        }
        
        UserDefaults.standard.set(keywords, forKey: keywordKey)
        
        return fetchKeywords()
    }
    
    func deleteAllKeywords() -> [String] {
        UserDefaults.standard.removeObject(forKey: keywordKey)
        
        return fetchKeywords()
    }
    
    func setTabType(type: TabType) {
        UserDefaults.standard.set(type.rawValue, forKey: tabTypeKey)
    }
    
    func fetchTabType() -> TabType {
        let rawValue = UserDefaults.standard.string(forKey: tabTypeKey) ?? TabType.discovery.rawValue
        return TabType(rawValue: rawValue) ?? TabType.discovery
    }
}
