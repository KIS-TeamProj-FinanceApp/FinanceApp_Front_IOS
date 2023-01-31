//
//  DomesticNowPriceDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation


struct DomesticNowPriceTotalDto: Decodable {
    
    let output: [DomesticNowPriceDto]
    
    enum CodingKeys: String, CodingKey{
        case output = "output"
    }
}


struct DomesticNowPriceDto: Decodable {
    // 주식 현재가
    let stck_prpr: String
    // 상한가
    let stck_mxpr: String
    // 하한가
    let stck_llam: String
    // 시가
    let stck_oprc: String
    // 최고가
    let stck_hgpr: String
    // 최저가
    let stck_lwpr: String
    // PER
    let per: String
    // EPS
    let eps: String
    // PBR
    let pbr: String
    // 전일 대비 거래량
    let prdy_vrss_vol: String
    
    enum CodingKeys: String, CodingKey{
        case stck_prpr = "stck_prpr"
        case stck_mxpr = "stck_mxpr"
        case stck_llam = "stck_llam"
        case stck_oprc = "stck_oprc"
        case stck_hgpr = "stck_hgpr"
        case stck_lwpr = "stck_lwpr"
        case per = "per"
        case eps = "eps"
        case pbr = "pbr"
        case prdy_vrss_vol = "prdy_vrss_vol"
    }
}

