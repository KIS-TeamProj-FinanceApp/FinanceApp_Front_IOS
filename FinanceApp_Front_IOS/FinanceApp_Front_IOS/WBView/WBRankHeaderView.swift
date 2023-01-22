//
//  WBRankHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

class WBRankHeaderView: UIView {
    
    private lazy var investorTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 3.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 235/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "투자자 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var investorLabel: UILabel = {
        let label = UILabel()
        label.text = "  'S PICK"
        label.font = .systemFont(ofSize: 34.0, weight: .semibold)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [investorTextField, investorLabel].forEach{
            self.addSubview($0)
        }
        
        investorTextField.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(UIScreen.main.bounds.size.width  / 2)
//            $0.centerX.equalToSuperview().inset(UIScreen.main.bounds.size.width / 3)
            $0.height.equalToSuperview().inset(8)
            $0.width.equalTo(120)
//            $0.top.equalToSuperview().inset(10)
//            $0.leading.equalToSuperview().inset(30)
            
        }
        
        investorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(investorTextField.snp.trailing)
        }
    }
}
