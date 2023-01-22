//
//  WBRankTableViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

final class WBRankTableViewCell: UITableViewCell {
    
    private lazy var imgView: UIImageView = {
        
        let iv = UIImageView(image: UIImage(named: "one"))
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private lazy var securityLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3.0
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        label.backgroundColor = .white
        label.text = "Apple Inc"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        
    }
    
    private func layout(){
        [imgView, securityLabel].forEach{
            addSubview($0)
        }
        
        imgView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(imgView.snp.height)
        }
        
        securityLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.equalTo(imgView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
