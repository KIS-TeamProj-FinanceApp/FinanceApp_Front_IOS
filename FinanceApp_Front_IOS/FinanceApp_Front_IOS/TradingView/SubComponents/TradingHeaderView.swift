//
//  TradingHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import UIKit
import SnapKit


class TradingHeaderView: UIView {
    
        
    private lazy var jongMokMyungLabel: UILabel = {
        let label = UILabel()
        label.text = "종목명"
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        return label
    }()
    
    private lazy var daePyoSiJangLabel: UILabel = {
        let label = UILabel()
        
        label.text = "대표시장"
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private lazy var sectorLabel: UILabel = {
        let label = UILabel()
        label.text = "업종"
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private lazy var prdy_ctrtLabel: UILabel = {
        let label = UILabel()
        label.text = "전일대비율"
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        return label
    }()
    
    private lazy var prdy_vrssLabel: UILabel = {
        let label = UILabel()
        label.text = "전일 대비"
        label.font = .systemFont(ofSize: 24.0, weight: .semibold)
        return label
    }()
    
    
    
    
    
    
    
    //누적 거래량
    private lazy var acml_volLabel: UILabel = {
        let label = UILabel()
        label.text = "누적거래량 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var acml_vol_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //주식 시가
    private lazy var stck_oprcLabel: UILabel = {
        let label = UILabel()
        label.text = "시가 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var stck_oprc_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //주식 최고가
    private lazy var stck_hgprLabel: UILabel = {
        let label = UILabel()
        label.text = "최고가 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var stck_hgpr_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //주식 최저가
    private lazy var stck_lwprLabel: UILabel = {
        let label = UILabel()
        label.text = "최저가 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var stck_lwpr_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //주식 상한가
    private lazy var stck_mxprLabel: UILabel = {
        let label = UILabel()
        label.text = "상한가 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var stck_mxpr_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //주식 하한가
    private lazy var stck_llamLabel: UILabel = {
        let label = UILabel()
        label.text = "하한가 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var stck_llam_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        return label
    }()
    
    //외국인 순매수 수량
    private lazy var frgn_ntby_qtyLabel: UILabel = {
        let label = UILabel()
        label.text = "외국인 순매수 :"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    private lazy var frgn_ntby_qty_value: UILabel = {
        let label = UILabel()
        label.text = "acml_vol"
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
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
    
    func setup(jongmok: String, market: String, sector: String, prdy_vrss: String, prdy_vrss_sign: String, prdy_ctrt: String, acml_vol: String, stck_oprc: String, stck_hgpr: String, stck_lwpr: String, stck_mxpr: String, stck_llam: String, frgn_ntby_qty: String, isDomestic: Bool){
        self.jongMokMyungLabel.text = jongmok
        self.daePyoSiJangLabel.text = market
        self.sectorLabel.text = sector
        self.prdy_ctrtLabel.text = prdy_ctrt + "%"
        self.prdy_vrssLabel.text = prdy_vrss
        
        self.acml_vol_value.text = acml_vol
        self.stck_oprc_value.text = stck_oprc
        self.stck_hgpr_value.text = stck_hgpr
        self.stck_lwpr_value.text = stck_lwpr
        self.stck_mxpr_value.text = stck_mxpr
        self.stck_llam_value.text = stck_llam
        self.frgn_ntby_qty_value.text = frgn_ntby_qty
        
        if prdy_vrss_sign == "1" || prdy_vrss_sign == "2" { //상승
            self.prdy_ctrtLabel.textColor = .red
            self.prdy_vrssLabel.textColor = .red
        }else if prdy_vrss_sign == "3"{ // 보합
            self.prdy_ctrtLabel.textColor = .black
            self.prdy_vrssLabel.textColor = .black
        }else { // 하락
            self.prdy_ctrtLabel.textColor = .blue
            self.prdy_vrssLabel.textColor = .blue
        }
        
        if isDomestic{
            self.frgn_ntby_qtyLabel.text = "외국인 순매수 :"
        }else{
            self.frgn_ntby_qtyLabel.text = ""
        }
    }
    
    private func layout(){
        [jongMokMyungLabel, daePyoSiJangLabel, sectorLabel, prdy_ctrtLabel, prdy_vrssLabel,  acml_volLabel, acml_vol_value, stck_oprcLabel, stck_oprc_value, stck_hgprLabel, stck_hgpr_value, stck_lwprLabel, stck_lwpr_value, stck_mxprLabel, stck_mxpr_value, stck_llamLabel, stck_llam_value, frgn_ntby_qtyLabel, frgn_ntby_qty_value].forEach{
            self.addSubview($0)
        }
        
        jongMokMyungLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(12)
        }
        
        daePyoSiJangLabel.snp.makeConstraints{
            $0.top.equalTo(jongMokMyungLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(12)
        }
        
        sectorLabel.snp.makeConstraints{
            $0.top.equalTo(jongMokMyungLabel.snp.bottom).offset(2)
            $0.leading.equalTo(daePyoSiJangLabel.snp.trailing).offset(4)
        }
        
        prdy_ctrtLabel.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(12)
        }
        
        prdy_vrssLabel.snp.makeConstraints{
            $0.top.equalTo(prdy_ctrtLabel.snp.bottom).offset(2)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        // -------
        
        
        acml_volLabel.snp.makeConstraints{
            $0.top.equalTo(prdy_vrssLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(12)
        }
        
        acml_vol_value.snp.makeConstraints{
            $0.top.equalTo(prdy_vrssLabel.snp.bottom).offset(2)
            $0.leading.equalTo(acml_volLabel.snp.trailing).offset(4)
        }
        
        stck_oprcLabel.snp.makeConstraints{
            $0.top.equalTo(prdy_vrssLabel.snp.bottom).offset(2)
            $0.leading.equalTo(acml_vol_value.snp.trailing).offset(10)
        }
        
        stck_oprc_value.snp.makeConstraints{
            $0.top.equalTo(prdy_vrssLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_oprcLabel.snp.trailing).offset(4)
        }
        
        
        
        
        stck_hgprLabel.snp.makeConstraints{
            $0.top.equalTo(acml_volLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(12)
        }
        
        stck_hgpr_value.snp.makeConstraints{
            $0.top.equalTo(acml_volLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_hgprLabel.snp.trailing).offset(4)
        }
        
        stck_lwprLabel.snp.makeConstraints{
            $0.top.equalTo(acml_volLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_hgpr_value.snp.trailing).offset(10)
        }
        
        stck_lwpr_value.snp.makeConstraints{
            $0.top.equalTo(acml_volLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_lwprLabel.snp.trailing).offset(4)
        }
        
        
        
        
        stck_mxprLabel.snp.makeConstraints{
            $0.top.equalTo(stck_hgprLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(12)
        }
        
        stck_mxpr_value.snp.makeConstraints{
            $0.top.equalTo(stck_hgprLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_mxprLabel.snp.trailing).offset(4)
        }
        
        stck_llamLabel.snp.makeConstraints{
            $0.top.equalTo(stck_hgprLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_mxpr_value.snp.trailing).offset(10)
        }
        
        stck_llam_value.snp.makeConstraints{
            $0.top.equalTo(stck_hgprLabel.snp.bottom).offset(2)
            $0.leading.equalTo(stck_llamLabel.snp.trailing).offset(4)
        }
        
        
        
        
        frgn_ntby_qtyLabel.snp.makeConstraints{
            $0.top.equalTo(stck_mxprLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(12)
        }
        
        frgn_ntby_qty_value.snp.makeConstraints{
            $0.top.equalTo(stck_mxprLabel.snp.bottom).offset(2)
            $0.leading.equalTo(frgn_ntby_qtyLabel.snp.trailing).offset(4)
        }
        
        
    }
    
}
