//
//  MyOverseasMoneyDto.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/26.
//


import Foundation

struct MyOverseasMoneyDto: Decodable {
//    해외총손익 ovrs_tot_pfls
//    총수익률 tot_pftrt
//    총평가금액 tot_evlu_pfls_amt
//    외화매입금액 frcr_pchs_amt1
    
    //해외총손익
    let ovrs_tot_pfls: String
    //총수익률
    let tot_pftrt: String
    //총평가금액
    let tot_evlu_pfls_amt: String
    //외화매입금액
    let frcr_pchs_amt1: String
    
    enum CodingKeys: String, CodingKey{
        case ovrs_tot_pfls = "ovrs_tot_pfls"
        case tot_pftrt = "tot_pftrt"
        case tot_evlu_pfls_amt = "tot_evlu_pfls_amt"
        case frcr_pchs_amt1 = "frcr_pchs_amt1"
    }
}
