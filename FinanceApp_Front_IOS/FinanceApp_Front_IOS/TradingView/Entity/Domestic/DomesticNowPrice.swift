//
//  DomesticNowPrice.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation



struct DomesticNowPrice {
    // 대표시장 한글명
    let rprs_mrkt_kor_name: String
    // 업종
    let bstp_kor_isnm: String
    
    
    // 전일 대비
    let prdy_vrss: String
    // 전일대비부호
    let prdy_vrss_sign: String
    // 전일대비율
    let prdy_ctrt: String
    
    
    // 누적 거래량
    let acml_vol: String
    // 주식 시가
    let stck_oprc: String
    // 주식 최고가
    let stck_hgpr: String
    // 주식 최저가
    let stck_lwpr: String
    // 주식 상한가
    let stck_mxpr: String
    // 주식 하한가
    let stck_llam: String
    // 외국인 순매수 수량
    let frgn_ntby_qty: String
    
    // 호가 단위
    let aspr_unit: String
    // 52주일 최고가
    let w52_hgpr: String
    // 52주일 최저가
    let w52_lwpr: String
    
}

