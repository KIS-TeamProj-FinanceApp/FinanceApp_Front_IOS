//
//  TradingHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import UIKit
import SnapKit


class TradingHeaderView: UIView {
    
//    // 누적거래량
//    let acml_vol: String
//    //전일대비 거래량 비율
//    let prdy_vrss_vol_rate: String
//    // 전일대비 부호 1: 상한  2: 상승  3: 보합 4: 하한  5: 하락
//    let prdy_vrss_sign: String
//    // 전일 대비율 ( 얼마나 오르거나 하락했는지 )
//    let prdy_ctrt: String
//    // 외국인 순매수 수량
//    let frgn_ntby_qty: String
    
    private lazy var acml_vol_label: UILabel = {
        let label = UILabel()
        label.text = "누적거래량  "
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var acml_vol_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    private lazy var prdy_vrss_vol_rate_label: UILabel = {
        let label = UILabel()
        
        label.text = "전일대비 거래량 비율  "
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var prdy_vrss_vol_rate_value: UILabel = {
        let label = UILabel()
        label.text = "prdy_vrss_vol_rate"
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    private lazy var prdy_ctrt_label: UILabel = {
        let label = UILabel()
        label.text = "전일 대비  "
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var prdy_ctrt_value: UILabel = {
        let label = UILabel()
        label.text = "prdy_vrss_sign"
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    private lazy var frgn_ntby_qty_label: UILabel = {
        let label = UILabel()
        label.text = "외국인 순매수 수량  "
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        return label
    }()
    
    private lazy var frgn_ntby_qty_value: UILabel = {
        let label = UILabel()
        label.text = "frgn_ntby_qty"
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(v1: String, v2: String, v3: String, v4: String){
        self.acml_vol_value.text = v1
        self.prdy_vrss_vol_rate_value.text = v2
        self.prdy_ctrt_value.text = v3
        self.frgn_ntby_qty_value.text = v4
    }
    
    private func layout(){
        [acml_vol_label, acml_vol_value, prdy_vrss_vol_rate_label, prdy_vrss_vol_rate_value, prdy_ctrt_label, prdy_ctrt_value, frgn_ntby_qty_label, frgn_ntby_qty_value ].forEach{
            self.addSubview($0)
        }
        
        acml_vol_label.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(20)
        }
        
        acml_vol_value.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(acml_vol_label.snp.trailing).offset(10)
        }
        
        prdy_vrss_vol_rate_label.snp.makeConstraints{
            $0.top.equalTo(acml_vol_label.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        prdy_vrss_vol_rate_value.snp.makeConstraints{
            $0.top.equalTo(acml_vol_label.snp.bottom).offset(10)
            $0.leading.equalTo(prdy_vrss_vol_rate_label.snp.trailing).offset(10)
        }
        
        prdy_ctrt_label.snp.makeConstraints{
            $0.top.equalTo(prdy_vrss_vol_rate_label.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        prdy_ctrt_value.snp.makeConstraints{
            $0.top.equalTo(prdy_vrss_vol_rate_label.snp.bottom).offset(10)
            $0.leading.equalTo(prdy_ctrt_label.snp.trailing).offset(10)
        }
        
        frgn_ntby_qty_label.snp.makeConstraints{
            $0.top.equalTo(prdy_ctrt_label.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        frgn_ntby_qty_value.snp.makeConstraints{
            $0.top.equalTo(prdy_ctrt_label.snp.bottom).offset(10)
            $0.leading.equalTo(frgn_ntby_qty_label.snp.trailing).offset(10)
        }
    }
    
}
