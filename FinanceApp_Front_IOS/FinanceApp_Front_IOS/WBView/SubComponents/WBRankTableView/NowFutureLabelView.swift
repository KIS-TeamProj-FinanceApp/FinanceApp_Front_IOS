//
//  NowFutureLabelView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit


class NowFutureLabelView: UIView {
    
    // ----------------------------------------- Variables ---------------------------------------- //
    
    private var investorName: String = "Goldman"
    
    // ----------------------------------------- Variables ---------------------------------------- //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var investorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20.0, weight: .semibold)
        return label
    }()
  
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "NOW"
        label.font = .systemFont(ofSize: 34.0, weight: .semibold)
        return label
    }()
    
   
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [investorLabel, backLabel].forEach{
            self.addSubview($0)
        }
        
        investorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(UIScreen.main.bounds.size.width  / 2)
//            $0.centerX.equalToSuperview().inset(UIScreen.main.bounds.size.width / 3)
            $0.height.equalToSuperview().inset(8)
            $0.width.equalTo(120)
//            $0.top.equalToSuperview().inset(10)
//            $0.leading.equalToSuperview().inset(30)
        }
        
        backLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(investorLabel.snp.trailing)
        }
    }
}

