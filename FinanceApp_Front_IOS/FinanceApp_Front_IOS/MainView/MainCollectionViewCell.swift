//
//  MainCollectionViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/02/01.
//

import UIKit
import SnapKit

final class MainCollectionViewCell: UICollectionViewCell{
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var stockLabel: UILabel = {
        let label = UILabel()
        label.text = "한국금융지주"
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 196/255.0, alpha: 1.0).cgColor
        self.layer.cornerRadius = 8.0
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
        [rankLabel, stockLabel].forEach{
            addSubview($0)
        }
        
        rankLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
        
        stockLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
    
    func setup(rank: String, stock: String){
        self.rankLabel.text = rank
        self.stockLabel.text = stock
        
        if rank == "1"{
            self.rankLabel.textColor = .red
        }
        else if rank == "2"{
            self.rankLabel.textColor = .orange
        }
        else if rank == "3"{
            self.rankLabel.textColor = .yellow
        }
        else{
            self.rankLabel.textColor = .black
        }
    }
    
   
    
}
