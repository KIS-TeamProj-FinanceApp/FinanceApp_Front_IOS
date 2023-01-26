//
//  MyAccount.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import Foundation


struct MyAccount {
    
    // access token
//    let securities: [SecuritiesDto]?
    // 토큰 타입 - Bearer만 옴
    let money: MoneyObject
    // 메시지 코드 ( 별 의미 없음 )
    let msg_cd: String
    
    enum CodingKeys: String, CodingKey{
//        case securities = "output1"
        case money = "output2"
        case msg_cd = "msg_cd"
    }
}


struct MoneyObject{
    let totalMoney: String

}

