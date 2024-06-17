//
//  SigunguResponseDTO+Mapping.swift
//  TravelTale
//
//  Created by 김정호 on 6/17/24.
//

import Foundation

struct SigunguResponseDTO: Decodable {
    let response: SigunguContentDTO
}

extension SigunguResponseDTO {
    struct SigunguContentDTO: Decodable {
        let header: SigunguHeaderDTO
        let body: SigunguBodyDTO
    }
    
    struct SigunguHeaderDTO: Decodable {
        let resultCode: String
        let resultMsg: String
    }
    
    struct SigunguBodyDTO: Decodable {
        let items: SigungusDTO
        let numOfRows: Int
        let pageNo: Int
        let totalCount: Int
    }
    
    struct SigungusDTO: Decodable {
        let item: [SigunguDTO]
    }
    
    struct SigunguDTO: Decodable {
        let rnum: Int
        let code: String
        let name: String
    }
}

extension SigunguResponseDTO.SigungusDTO {
    func toDomain() -> Sigungus {
        return .init(sigungus: item.map { $0.toDomain() })
    }
}

extension SigunguResponseDTO.SigunguDTO {
    func toDomain() -> Sigungu {
        return .init(code: code,
                     name: name)
    }
}
