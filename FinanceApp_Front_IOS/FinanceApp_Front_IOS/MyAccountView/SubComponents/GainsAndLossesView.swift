//
//  GainsAndLossesView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/23.
//

import UIKit

class GainsAndLossesView: UIView {
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "평가손익"
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        return label
    }()
    
    private lazy var wonLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00%"
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .systemRed
        return label
    }()
    

    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    @objc func marketChange(){
        print("marketChange button clicked")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
       
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [titleLabel, wonLabel, percentLabel].forEach{
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        percentLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    
        wonLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(percentLabel.snp.leading).offset(-20)
        }
    }
    
    func setup(totalRevenue: String, totalRevenueRate: String){
        self.wonLabel.text = totalRevenue
        self.percentLabel.text = totalRevenueRate
    }
}
