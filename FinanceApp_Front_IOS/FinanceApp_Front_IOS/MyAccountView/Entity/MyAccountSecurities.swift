//
//  MyAccountSecurities.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//


import Foundation

struct MyAccountSecurities {
    // 종목명 prdt_name
    // 종목코드 pdno
    //평가손익 evlu_pfls_amt
    //수익률 = 평가손익률 evlu_pfls_rt
    //평가금액 evlu_amt
    //보유수량 hldg_qty
    //매입금액 pchs_amt
    //매입단가 pchs_avg_pric
    //현재가 prpr
    //등락률 fltt_rt
    //금일매수 thdt_buyqty
    //금일매도 thdt_sll_qty
    
    //종목명
    let prdt_name: String
    //종목코드
    let pdno: String
    //평가손익
    let evlu_pfls_amt: String
    //수익률
    let evlu_pfls_rt: String
    //평가금액
    let evlu_amt: String
    // 보유수량
    let hldg_qty: String
    //매입금액
    let pchs_amt: String
    //매입단가
    let pchs_avg_pric: String
    //현재가
    let prpr: String
    //등락률
    let fltt_rt: String
    //금일매수
    let thdt_buyqty: String
    //금일매도
    let thdt_sll_qty: String
}
