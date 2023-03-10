//
//  SecurityDataCellData.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//

import Foundation

//날짜정보 / 종목코드 / 종목명 / 상장시장명 / 시가 / 종가 / 최고가 / 최저가
struct SecurityDataCellData {
    // 날짜정보 ex) 20221228
    let basDt: String?
    // 종목코드
    let strnCd: String?
    // 종목명 ex) 삼성전자
    let itmsNm: String?
    // 상장된 시장명 KOSPI, KOSDAQ, KONEX 중 하나mrktCtg
    let mrktCtg: String?
    
    //시가 ( 9시 )
    let mkp: String?
    //종가
    let clpr: String?
    //하루 중 최고가
    let hipr: String?
    //하루 중 최저가
    let lopr: String?
    
    
//    var data: String {
//        get {
//            return basDt ?? "nil" + " " + strnCd ?? "nil" + " " + itmsNm ?? "nil" + " " + mrktCtg ?? "nil" + " " + mkp ?? "nil" + " " + clpr ?? "nil" + " " + hipr ?? "nil" + " " + lopr ?? "nil"
//        }
//    }
}
