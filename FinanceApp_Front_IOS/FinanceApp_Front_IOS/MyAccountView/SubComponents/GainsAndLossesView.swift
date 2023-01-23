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
    
    private lazy var changeButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .systemBackground
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("  0.00%  ", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        btn.addTarget(self, action: #selector(marketChange), for: .touchUpInside)
        return btn
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
        [titleLabel, changeButton].forEach{
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        changeButton.snp.makeConstraints{
            $0.top.trailing.equalToSuperview().inset(20)
        }
    
    }
}
