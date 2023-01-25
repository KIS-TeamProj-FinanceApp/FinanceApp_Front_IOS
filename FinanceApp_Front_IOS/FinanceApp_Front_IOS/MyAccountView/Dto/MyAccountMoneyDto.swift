//
//  MyAccountMoneyDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//

import Foundation

struct MyAccountMoneyDto: Decodable {
//    예수금 총액 dnca_tot_amt
//    D+2예수금 d2_auto_rdpt_amt
//    평가금액 scts_evlu_amt
//    매입금액합계 thdt_buy_amt
//    평가손익합계금액 evlu_pfls_smtl_amt
    
    //평가손익합계금액
    let evlu_pfls_smtl_amt: String
    //예수금 총액
    let dnca_tot_amt: String
    //D+2예수금
    let d2_auto_rdpt_amt: String
    //평가금액
    let scts_evlu_amt: String
    //매입금액합계
    let pchs_amt_smtl_amt: String
    
    
    enum CodingKeys: String, CodingKey{
        case evlu_pfls_smtl_amt = "evlu_pfls_smtl_amt"
        case dnca_tot_amt = "dnca_tot_amt"
        case d2_auto_rdpt_amt = "d2_auto_rdpt_amt"
        case scts_evlu_amt = "scts_evlu_amt"
        case pchs_amt_smtl_amt = "pchs_amt_smtl_amt"
    }
}
