//
//  SecurityCollectionViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//

import UIKit

final class SecurityCollectionViewCell: UICollectionViewCell{
    
    private lazy var titleButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
//        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.backgroundColor = .white
        titleButton.layer.borderWidth = 1.0
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func layout() {
        [ titleButton].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(title: String){
        titleButton.setTitle(title, for: .normal)
    }
}
