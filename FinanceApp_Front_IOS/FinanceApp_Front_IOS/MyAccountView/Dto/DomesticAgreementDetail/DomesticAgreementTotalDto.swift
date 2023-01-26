//
//  DomesticAgreementTotalDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//

import Foundation

struct DomesticAgreementTotalDto: Decodable {
    
    // 체결내역 관련 내용
    let output1: [DomesticAgreementDetailDto]
    
    
    enum CodingKeys: String, CodingKey{
        case output1 = "output1"
    }
}
