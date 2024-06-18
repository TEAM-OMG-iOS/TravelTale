//
//  PlaceDetailResponseDTO+Mapping.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation

struct PlaceDetailResponseDTO: Decodable {
    let response: PlaceDetailContentDTO
}

extension PlaceDetailResponseDTO {
    struct PlaceDetailContentDTO: Decodable {
        let header: PlaceDetailHeaderDTO
        let body: PlaceDetailBodyDTO
    }
    
    struct PlaceDetailHeaderDTO: Decodable {
        let resultCode: String
        let resultMsg: String
    }
    
    struct PlaceDetailBodyDTO: Decodable {
        let items: PlaceDetailsDTO
        let numOfRows: Int
        let pageNo: Int
        let totalCount: Int
    }
    
    struct PlaceDetailsDTO: Decodable {
        let item: [PlaceDetailDTO]
    }
    
    struct PlaceDetailDTO: Decodable {
        let contentId: String
        let contentTypeId: String
        let title: String
        let createdTime: String
        let modifiedTime: String
        let tel: String
        let telName: String
        let homepage: String
        let bookTour: String
        let firstImage: String
        let firstImage2: String
        let cpyrhtDivCd: String
        let addr1: String
        let addr2: String
        let zipCode: String
        let mapx: String
        let mapy: String
        let mLevel: String
        let overview: String
        
        enum CodingKeys: String, CodingKey {
            case contentId = "contentid"
            case contentTypeId = "contenttypeid"
            case title = "title"
            case createdTime = "createdtime"
            case modifiedTime = "modifiedtime"
            case tel = "tel"
            case telName = "telname"
            case homepage = "homepage"
            case bookTour = "booktour"
            case firstImage = "firstimage"
            case firstImage2 = "firstimage2"
            case cpyrhtDivCd = "cpyrhtDivCd"
            case addr1 = "addr1"
            case addr2 = "addr2"
            case zipCode = "zipcode"
            case mapx = "mapx"
            case mapy = "mapy"
            case mLevel = "mlevel"
            case overview = "overview"
        }
    }
}

extension PlaceDetailResponseDTO.PlaceDetailsDTO {
    func toDomain() -> PlaceDetails {
        return .init(placeDetails: item.map { $0.toDomain() })
    }
}

extension PlaceDetailResponseDTO.PlaceDetailDTO {
    func toDomain() -> PlaceDetail {
        return .init(contentId: contentId,
                     contentTypeId: contentTypeId,
                     title: title,
                     tel: tel,
                     homepage: homepage,
                     firstImage: firstImage,
                     firstImage2: firstImage2,
                     cpyrhtDivCd: cpyrhtDivCd,
                     addr1: addr1,
                     addr2: addr2,
                     mapx: mapx,
                     mapy: mapy,
                     overview: overview)
    }
}
