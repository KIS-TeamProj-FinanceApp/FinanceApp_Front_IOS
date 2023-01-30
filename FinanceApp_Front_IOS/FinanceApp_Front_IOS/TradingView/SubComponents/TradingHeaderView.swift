//
//  TradingHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import UIKit
import SnapKit


class TradingHeaderView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "this is Header"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [label].forEach{
            self.addSubview($0)
        }
        
        label.snp.makeConstraints{
            $0.centerY.centerX.equalToSuperview()
        }
        
    }
    
}
