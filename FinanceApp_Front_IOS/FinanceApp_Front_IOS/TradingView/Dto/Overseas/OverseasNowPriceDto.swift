//
//  OverseasNowPriceDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation



struct OverseasPriceTotalDto: Decodable {
    
    let output1: OverseasNowPriceDto
    let output2: [OverseasPriceDto]
    
    enum CodingKeys: String, CodingKey{
        case output1 = "output1"
        case output2 = "output2"
    }
}


struct OverseasNowPriceDto: Decodable {
    // 전일 대비
    let ovrs_nmix_prdy_vrss: String
    // 전일 대비 부호
    let prdy_vrss_sign: String
    // 전일 대비율
    let prdy_ctrt: String
    // 전일 종가
    let ovrs_nmix_prdy_clpr: String
    // 누적 거래량
    let acml_vol: String
    // 한글 종목명
    let hts_kor_isnm: String
    // 현재가
    let ovrs_nmix_prpr: String
    // 단축 종목코드
    let stck_shrn_iscd: String
    // 시가
    let ovrs_prod_oprc: String
    // 최고가
    let ovrs_prod_hgpr: String
    // 최저가
    let ovrs_prod_lwpr: String
    
    
    enum CodingKeys: String, CodingKey{
        case ovrs_nmix_prdy_vrss = "ovrs_nmix_prdy_vrss"
        case prdy_vrss_sign = "prdy_vrss_sign"
        case prdy_ctrt = "prdy_ctrt"
        case ovrs_nmix_prdy_clpr = "ovrs_nmix_prdy_clpr"
        case acml_vol = "acml_vol"
        case hts_kor_isnm = "hts_kor_isnm"
        case ovrs_nmix_prpr = "ovrs_nmix_prpr"
        case stck_shrn_iscd = "stck_shrn_iscd"
        case ovrs_prod_oprc = "ovrs_prod_oprc"
        case ovrs_prod_hgpr = "ovrs_prod_hgpr"
        case ovrs_prod_lwpr = "ovrs_prod_lwpr"
    }
}

