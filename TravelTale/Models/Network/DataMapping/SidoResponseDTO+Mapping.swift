//
//  SidoResponseDTO+Mapping.swift
//  TravelTale
//
//  Created by 김정호 on 6/16/24.
//

import Foundation

struct SidoResponseDTO: Decodable {
    let response: SidoContentDTO
}

extension SidoResponseDTO {
    struct SidoContentDTO: Decodable {
        let header: SidoHeaderDTO
        let body: SidoBodyDTO
    }
    
    struct SidoHeaderDTO: Decodable {
        let resultCode: String
        let resultMsg: String
    }
    
    struct SidoBodyDTO: Decodable {
        let items: SidosDTO
        let numOfRows: Int
        let pageNo: Int
        let totalCount: Int
    }
    
    struct SidosDTO: Decodable {
        let item: [SidoDTO]
    }
    
    struct SidoDTO: Decodable {
        let rnum: Int
        let code: String
        let name: String
    }
}

extension SidoResponseDTO.SidosDTO {
    func toDomain() -> Sidos {
        return .init(sidos: item.map { $0.toDomain() })
    }
}

extension SidoResponseDTO.SidoDTO {
    func toDomain() -> Sido {
        return .init(code: code,
                     name: name)
    }
}
