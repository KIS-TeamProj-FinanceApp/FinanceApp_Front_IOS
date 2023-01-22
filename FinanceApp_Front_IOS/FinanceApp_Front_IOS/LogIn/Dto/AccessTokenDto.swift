//
//  AccessTokenDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import Foundation


struct AccessTokenDto: Decodable {
    
    // access token
    let access_token: String?
    // 토큰 타입 - Bearer만 옴
    let token_type: String?
    // 만료 시간
    let expires_in: Int?
    
    enum CodingKeys: String, CodingKey{
        case access_token = "access_token"
        case token_type = "token_type"
        case expires_in = "expires_in"
    }
}
