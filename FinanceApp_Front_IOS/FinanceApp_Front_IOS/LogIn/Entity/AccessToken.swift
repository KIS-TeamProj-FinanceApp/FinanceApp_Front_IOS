//
//  AccessToken.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import Foundation

struct AccessToken {
    // access token
    let access_token: String
    // 토큰 타입 - Bearer만 옴
    let token_type: String
    // 만료 시간
    let expires_in: Int
}
