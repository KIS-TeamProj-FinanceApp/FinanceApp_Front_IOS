//
//  DomesticSector.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import Foundation

struct DomesticSector: Decodable {

    //종목명
    let bstp_kor_isnm: String

    enum CodingKeys: String, CodingKey{
        case bstp_kor_isnm = "bstp_kor_isnm"
    }
}

