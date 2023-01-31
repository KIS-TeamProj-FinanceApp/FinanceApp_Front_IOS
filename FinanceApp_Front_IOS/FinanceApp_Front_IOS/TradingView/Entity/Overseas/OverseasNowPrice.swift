//
//  OverseasNowPrice.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation

struct OverseasNowPrice {
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
}
