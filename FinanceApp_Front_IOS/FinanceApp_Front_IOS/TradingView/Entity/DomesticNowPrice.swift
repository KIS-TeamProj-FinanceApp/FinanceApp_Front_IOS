//
//  DomesticNowPrice.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation


struct DomesticNowPriceDto {
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
}

