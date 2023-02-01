//
//  WBRankTableViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

final class WBRankTableViewCell: UITableViewCell {
    
//    private lazy var imgView: UIImageView = {
//
//        let iv = UIImageView(image: UIImage(named: "one"))
//        iv.layer.borderWidth = 1
//        iv.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
//        iv.layer.cornerRadius = 10
//        return iv
//    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var stockLabel: UILabel = {
        let label = UILabel()
//        label.layer.cornerRadius = 3.0
//        label.layer.borderWidth = 2.0
//        label.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        label.backgroundColor = .white
        label.text = "Apple Inc"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout(){
        [rankLabel, stockLabel].forEach{
            addSubview($0)
        }
        
        rankLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(rankLabel.snp.height)
        }
        
        stockLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
//    func setup(rank: Int, securityName: String){
//        securityLabel.text = String(rank) + securityName
//
//    }
    func setup(rank: String, securityName: String){
        self.rankLabel.text = rank
        self.stockLabel.text = securityName
        
        if rank == "1"{
            self.rankLabel.textColor = .red
//            self.rankLabel.font = .systemFont(ofSize: 32.0, weight: .heavy)
//            self.stockLabel.font = .systemFont(ofSize: 30.0, weight: .heavy)
        }
        else if rank == "2"{
            self.rankLabel.textColor = .orange
//            self.rankLabel.font = .systemFont(ofSize: 30.0, weight: .bold)
//            self.stockLabel.font = .systemFont(ofSize: 28.0, weight: .heavy)
        }
        else if rank == "3"{
            self.rankLabel.textColor = .blue
//            self.rankLabel.font = .systemFont(ofSize: 28.0, weight: .semibold)
//            self.stockLabel.font = .systemFont(ofSize: 26.0, weight: .heavy)
        }
        else{
            self.rankLabel.textColor = .black
//            self.rankLabel.font = .systemFont(ofSize: 26.0, weight: .semibold)
//            self.stockLabel.font = .systemFont(ofSize: 24.0, weight: .medium)
        }
    }
}
