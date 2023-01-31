//
//  OverseasPrice.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/31.
//

import Foundation

struct OverseasPrice {
    // 영업일자
    let stck_bsop_date: String
    // 현재가
    let ovrs_nmix_prpr: String
    // 시가
    let ovrs_nmix_oprc: String
    // 최고가
    let ovrs_nmix_hgpr: String
    // 최저가
    let ovrs_nmix_lwpr: String
    // 누적거래량
    let acml_vol: String
    //변경여부
    let mod_yn: String
}
