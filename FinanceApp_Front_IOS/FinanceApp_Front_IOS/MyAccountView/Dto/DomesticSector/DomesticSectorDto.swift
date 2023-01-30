//
//  DomesticSectorDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import Foundation

struct DomesticSectorTotalDto: Decodable {
    
    let output: DomesticSectorDto
    
    enum CodingKeys: String, CodingKey{
        case output = "output"
    }
}


struct DomesticSectorDto: Decodable {

    
    //종목명
    let bstp_kor_isnm: String
    
    
    enum CodingKeys: String, CodingKey{
        case bstp_kor_isnm = "bstp_kor_isnm"
        
    }
}

