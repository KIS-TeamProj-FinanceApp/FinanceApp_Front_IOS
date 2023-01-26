//
//  DomesticAgreementDetail.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//

import Foundation

struct DomesticAgreementDetail {
//    종목명 prdt_name
//    매매구분 sll_buy_dvsn_cd_name
//
//    매수매도구분 sll_buy_dvsn_cd    01매도 02매수
//    주문수량 ord_qty
//    체결평균 avg_prvs
//    체결수량 tot_ccld_qty
//    총결제금액 tot_ccld_amt
//    주문구분코드 ord_dvsn_cd    00지정가 01시장가
//    주문번호 odno
//    주문일 ord_dt
//    주문시간 ord_tmd
    
    //종목명
    let prdt_name: String
    //매매구분
    let sll_buy_dvsn_cd_name: String

    //매수매도구분
    let sll_buy_dvsn_cd: String    //01매도 02매수
    //주문수량
    let ord_qty: String
    //체결평균
    let avg_prvs: String
    //체결수량
    let tot_ccld_qty: String
    //총결제금액
    let tot_ccld_amt: String
    //주문구분코드
    let ord_dvsn_cd: String    //00지정가 01시장가
    //주문번호
    let odno: String
    //주문일
    let ord_dt: String
    //주문시간
    let ord_tmd: String
   
}

