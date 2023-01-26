//
//  MyOverseasTotalDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//

import Foundation

struct MyOverseasTotalDto: Decodable {
    
    // 주식 종목들 배열형태로 보내주는 곳
    let output1: [MyOverseasSecuritiesDto]
    // 계좌 수익률, 평가금액 등 돈 관련 정보 보내주는 곳
    let output2: MyOverseasMoneyDto
    
    enum CodingKeys: String, CodingKey{
        case output1 = "output1"
        case output2 = "output2"
    }
}
