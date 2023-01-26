//
//  MyOverseasMoneyDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//


import Foundation

struct MyOverseasMoneyDto: Decodable {
//    총손익 tot_evlu_pfls_amt
//    총수익률 evlu_erng_rt1
//    평가금액(외국주식) evlu_amt_smtl_amt
//    매입금액 pchs_amt_smtl_amt
//    총예수금 tot_frcr_cblc_smtl
//    예수금 총액(외화평가총액) frcr_evlu_tota
//

    
    //해외총손익
    let tot_evlu_pfls_amt: String
    //총수익률
    let evlu_erng_rt1: String
    
    
    //총평가금액
    let evlu_amt_smtl_amt: String
    //외화매입금액
    let pchs_amt_smtl_amt: String
    //총 예수금(원화 포함)
    let tot_frcr_cblc_smtl: String
    //예수금 총액(외호)
    let frcr_evlu_tota: String
    
    enum CodingKeys: String, CodingKey{
        case tot_evlu_pfls_amt = "tot_evlu_pfls_amt"
        case evlu_erng_rt1 = "evlu_erng_rt1"
        
        case evlu_amt_smtl_amt = "evlu_amt_smtl_amt"
        case pchs_amt_smtl_amt = "pchs_amt_smtl_amt"
        case tot_frcr_cblc_smtl = "tot_frcr_cblc_smtl"
        case frcr_evlu_tota = "frcr_evlu_tota"
    }
}
