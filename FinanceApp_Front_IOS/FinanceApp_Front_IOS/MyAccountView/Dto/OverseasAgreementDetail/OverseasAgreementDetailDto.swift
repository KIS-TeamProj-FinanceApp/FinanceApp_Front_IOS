//
//  OverseasAgreementDetailDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//


import Foundation

struct OverseasAgreementDetailDto: Decodable {
//    종목명  prdt_name
//    매매구분 sll_buy_dvsn_cd_name
//    매수매도구분 sll_buy_dvsn_cd    01매도 02매수
//    주문수량 ft_ord_qty
//    체결평균 ft_ccld_unpr3
//    체결수량 ft_ccld_qty
//    총결제금액 ft_ccld_amt3
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
    let ft_ord_qty: String
    //체결평균
    let ft_ccld_unpr3: String
    //체결수량
    let ft_ccld_qty: String
    //총결제금액
    let ft_ccld_amt3: String
    //주문번호
    let odno: String
    //주문일
    let ord_dt: String
    //주문시간
    let ord_tmd: String
   
    
    enum CodingKeys: String, CodingKey{
        case prdt_name = "prdt_name"
        case sll_buy_dvsn_cd_name = "sll_buy_dvsn_cd_name"
        case sll_buy_dvsn_cd = "sll_buy_dvsn_cd"
        case ft_ord_qty = "ft_ord_qty"
        case ft_ccld_unpr3 = "ft_ccld_unpr3"
        case ft_ccld_qty = "ft_ccld_qty"
        case ft_ccld_amt3 = "ft_ccld_amt3"
        case odno = "odno"
        case ord_dt = "ord_dt"
        case ord_tmd = "ord_tmd"
    }
}

