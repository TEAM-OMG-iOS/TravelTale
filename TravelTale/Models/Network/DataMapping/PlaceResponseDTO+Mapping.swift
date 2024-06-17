//
//  PlaceResponseDTO+Mapping.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation

struct PlaceResponseDTO: Decodable {
    let response: PlaceContentDTO
}

extension PlaceResponseDTO {
    struct PlaceContentDTO: Decodable {
        let header: PlaceHeaderDTO
        let body: PlaceBodyDTO
    }
    
    struct PlaceHeaderDTO: Decodable {
        let resultCode: String
        let resultMsg: String
    }
    
    struct PlaceBodyDTO: Decodable {
        let items: PlacesDTO
        let numOfRows: Int
        let pageNo: Int
        let totalCount: Int
    }
    
    struct PlacesDTO: Decodable {
        let item: [PlaceDTO]
    }
    
    struct PlaceDTO: Decodable {
        let addr1: String
        let addr2: String
        let areaCode: String
        let bookTour: String
        let cat1: String
        let cat2: String
        let cat3: String
        let contentId: String
        let contentTypeId: String
        let createdTime: String
        let firstImage: String
        let firstImage2: String
        let cpyrhtDivCd: String
        let mapx: String
        let mapy: String
        let mLevel: String
        let modifiedTime: String
        let sigunguCode: String
        let tel: String
        let title: String
        let zipCode: String
        
        enum CodingKeys: String, CodingKey {
            case addr1 = "addr1"
            case addr2 = "addr2"
            case areaCode = "areacode"
            case bookTour = "booktour"
            case cat1 = "cat1"
            case cat2 = "cat2"
            case cat3 = "cat3"
            case contentId = "contentid"
            case contentTypeId = "contenttypeid"
            case createdTime = "createdtime"
            case firstImage = "firstimage"
            case firstImage2 = "firstimage2"
            case cpyrhtDivCd = "cpyrhtDivCd"
            case mapx = "mapx"
            case mapy = "mapy"
            case mLevel = "mlevel"
            case modifiedTime = "modifiedtime"
            case sigunguCode = "sigungucode"
            case tel = "tel"
            case title = "title"
            case zipCode = "zipcode"
        }
    }
}

extension PlaceResponseDTO.PlacesDTO {
    func toDomain() -> Places {
        return .init(places: item.map { $0.toDomain() })
    }
}

extension PlaceResponseDTO.PlaceDTO {
    func toDomain() -> Place {
        return .init(addr1: addr1,
                     addr2: addr2,
                     contentId: contentId,
                     firstImage: firstImage,
                     title: title,
                     cpyrhtDivCd: cpyrhtDivCd)
    }
}
