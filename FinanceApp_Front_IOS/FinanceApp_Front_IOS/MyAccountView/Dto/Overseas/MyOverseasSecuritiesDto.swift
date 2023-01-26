//
//  MyOverseasSecuritiesDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//


import Foundation

struct MyOverseasSecuritiesDto: Decodable {
//    종목명 ovrs_item_name
//    종목코드 ovrs_pdno
//    외화평가손익금액 frcr_evlu_pfls_amt
//    평가손익률(개별주식) evlu_pfls_rt
//    매입단가 pchs_avg_pric
//    보유수량 ovrs_cblc_qty
//    평가금액 ovrs_stck_evlu_amt
//    해당종목현재가 now_pric2
//    거래통화코드 tr_crcy_cd
    
    //종목명
    let ovrs_item_name: String
    //종목코드
    let ovrs_pdno: String
    //외화평가손익금액
    let frcr_evlu_pfls_amt: String
    //평가손익률(개별주식)
    let evlu_pfls_rt: String
    //평가금액
    let ovrs_stck_evlu_amt: String
    // 보유수량
    let ovrs_cblc_qty: String
    //해당종목매입금액
    let frcr_pchs_amt1: String
    //매입단가
    let pchs_avg_pric: String
    //해당종목현재가
    let now_pric2: String
    //거래통화코드
    let tr_crcy_cd: String
   
    
    enum CodingKeys: String, CodingKey{
        case ovrs_item_name = "ovrs_item_name"
        case ovrs_pdno = "ovrs_pdno"
        case frcr_evlu_pfls_amt = "frcr_evlu_pfls_amt"
        case evlu_pfls_rt = "evlu_pfls_rt"
        case ovrs_stck_evlu_amt = "ovrs_stck_evlu_amt"
        case ovrs_cblc_qty = "ovrs_cblc_qty"
        case frcr_pchs_amt1 = "frcr_pchs_amt1"
        case pchs_avg_pric = "pchs_avg_pric"
        case now_pric2 = "now_pric2"
        case tr_crcy_cd = "tr_crcy_cd"
    }
}

