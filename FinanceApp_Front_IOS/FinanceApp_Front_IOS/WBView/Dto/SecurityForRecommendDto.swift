//
//  SecurityForRecommendDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import Foundation

struct SecurityForRecommendDto: Decodable {
    let securityName: String?
    let securitySector: String?
    ㅑ쇼
    enum CodingKeys: String, CodingKey{
        case securityName = "securityName"
        case securitySector = "securitySector"
    }
}
