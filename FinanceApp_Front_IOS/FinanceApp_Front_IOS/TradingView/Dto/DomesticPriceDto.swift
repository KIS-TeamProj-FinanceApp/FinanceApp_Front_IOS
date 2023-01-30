//
//  DomesticPriceDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation

struct DomesticPriceDto: Decodable {    
    // 영업일자
    let stck_bsop_date: String
    // 시가
    let stck_oprc: String
    // 최고가
    let stck_hgpr: String
    // 최저가
    let stck_lwpr: String
    // 종가
    let stck_clpr: String
    // 누적거래량
    let acml_vol: String
    //전일대비 거래량 비율
    let prdy_vrss_vol_rate: String
    // 전일대비 부호 1: 상한  2: 상승  3: 보합 4: 하한  5: 하락
    let prdy_vrss_sign: String
    // 전일 대비율 ( 얼마나 오르거나 하락했는지 )
    let prdy_ctrt: String
    // 외국인 순매수 수량
    let frgn_ntby_qty: String
    
    
    enum CodingKeys: String, CodingKey{
        case stck_bsop_date = "stck_bsop_date"
        case stck_oprc = "stck_oprc"
        case stck_hgpr = "stck_hgpr"
        case stck_lwpr = "stck_lwpr"
        case stck_clpr = "stck_clpr"
        case acml_vol = "acml_vol"
        case prdy_vrss_vol_rate = "prdy_vrss_vol_rate"
        case prdy_vrss_sign = "prdy_vrss_sign"
        case prdy_ctrt = "prdy_ctrt"
        case frgn_ntby_qty = "frgn_ntby_qty"
    }
}

