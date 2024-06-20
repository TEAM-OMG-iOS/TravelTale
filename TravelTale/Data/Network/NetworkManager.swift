//
//  NetworkManager.swift
//  TravelTale
//
//  Created by 김정호 on 6/16/24.
//

import Alamofire
import Foundation

enum Category: String {
    case total = ""
    case tourist = "12"
    case restaurant = "39"
    case accommodation = "32"
    case entertainment = "15"
}

final class NetworkManager {
    
    // MARK: - properties
    static let shared = NetworkManager()
    private init() {}
    
    // key
    private let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    
    // base
    private let baseUrl = "http://apis.data.go.kr/B551011/KorService1/"
    
    // path
    private let areaPath = "areaCode1"
    private let areaBasedPath = "areaBasedList1"
    private let detailPath = "detailCommon1"
    private let searchPath = "searchKeyword1"
    
    // common parameters
    private let commonParameters: Parameters = ["MobileOS": "IOS", "MobileApp": "TravelTale", "_type": "json"]
    
    // MARK: - methods
    func fetchSidos(completion: @escaping ((Result<Sidos, Error>) -> Void)) {
        var parameters: Parameters = ["numOfRows": "30"]
        parameters.merge(commonParameters) { (current, _) in current }
        
        AF.request(baseUrl + areaPath + "?serviceKey=\(apiKey)", parameters: parameters).responseDecodable(of: SidoResponseDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.response.body.items.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSigungus(sidoCode: String, completion: @escaping ((Result<Sigungus, Error>) -> Void)) {
        var parameters: Parameters = ["numOfRows": "30", "areaCode": sidoCode]
        parameters.merge(commonParameters) { (current, _) in current }
        
        AF.request(baseUrl + areaPath + "?serviceKey=\(apiKey)", parameters: parameters).responseDecodable(of: SigunguResponseDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.response.body.items.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPlaces(sidoCode: String, sigunguCode: String, type: Category, page: Int, completion: @escaping ((Result<Places, Error>) -> Void)) {
        var parameters: Parameters = ["arrange": "D", "areaCode": sidoCode, "sigunguCode": sigunguCode, "contentTypeId": type.rawValue, "pageNo": page]
        parameters.merge(commonParameters) { (current, _) in current }
        
        AF.request(baseUrl + areaBasedPath + "?serviceKey=\(apiKey)", parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: PlaceResponseDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.response.body.items.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPlaceDetail(contentId: String, completion: @escaping ((Result<PlaceDetails, Error>) -> Void)) {
        var parameters: Parameters = ["contentId": contentId, "defaultYN": "Y", "firstImageYN": "Y", "addrinfoYN": "Y", "mapinfoYN": "Y", "overviewYN": "Y"]
        parameters.merge(commonParameters) { (current, _) in current }
        
        AF.request(baseUrl + detailPath + "?serviceKey=\(apiKey)", parameters: parameters).responseDecodable(of: PlaceDetailResponseDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.response.body.items.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSearchedPlaces(sidoCode: String, sigunguCode: String, keyword: String, type: Category, page: Int, completion: @escaping ((Result<PlaceSearchs, Error>) -> Void)) {
        var parameters: Parameters = ["arrange": "D", "keyword": keyword, "areaCode": sidoCode, "sigunguCode": sigunguCode, "contentTypeId": type.rawValue, "pageNo": page]
        parameters.merge(commonParameters) { (current, _) in current }
        
        AF.request(baseUrl + searchPath + "?serviceKey=\(apiKey)", parameters: parameters, encoding: URLEncoding.queryString).responseDecodable(of: PlaceSearchResponseDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.response.body.items.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
