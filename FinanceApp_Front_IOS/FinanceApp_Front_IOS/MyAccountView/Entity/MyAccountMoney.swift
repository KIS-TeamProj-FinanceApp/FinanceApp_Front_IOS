//
//  MyAccountMoney.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//

import Foundation

struct MyAccountMoney {
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
    
}
