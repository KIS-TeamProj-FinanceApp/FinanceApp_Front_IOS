//
//  KeywordRankTableViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/02/01.
//

import UIKit
import SnapKit

final class KeywordRankTableViewCell: UITableViewCell {
    
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.text = "삼성전자"
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout(){
        [rankLabel, stockLabel].forEach{
            addSubview($0)
        }
        
        stockLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(stockLabel.snp.leading).offset(-10)
        }
    }
    
    func setup(rank: String, stock: String){
        self.rankLabel.text = rank
        self.stockLabel.text = stock
        
        if rank == "1"{
            self.rankLabel.textColor = .red
            self.rankLabel.font = .systemFont(ofSize: 32.0, weight: .heavy)
            self.stockLabel.font = .systemFont(ofSize: 30.0, weight: .heavy)
        }
        else if rank == "2"{
            self.rankLabel.textColor = .orange
            self.rankLabel.font = .systemFont(ofSize: 30.0, weight: .bold)
            self.stockLabel.font = .systemFont(ofSize: 28.0, weight: .heavy)
        }
        else if rank == "3"{
            self.rankLabel.textColor = .blue
            self.rankLabel.font = .systemFont(ofSize: 28.0, weight: .semibold)
            self.stockLabel.font = .systemFont(ofSize: 26.0, weight: .heavy)
        }
        else{
            self.rankLabel.textColor = .black
            self.rankLabel.font = .systemFont(ofSize: 26.0, weight: .semibold)
            self.stockLabel.font = .systemFont(ofSize: 24.0, weight: .medium)
        }
    }
}
