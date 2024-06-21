//
//  UserDefaultsManager.swift
//  TravelTale
//
//  Created by 김정호 on 6/16/24.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: - properties
    static let shared = UserDefaultsManager()
    private init() {}
    
    private let keywordKey = "keyword"
    
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
}
