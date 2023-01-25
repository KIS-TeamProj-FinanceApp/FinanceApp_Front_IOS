//
//  PortfolioView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/23.
//
import UIKit


class PortfolioView: UIView {
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "보유잔고"
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        return label
    }()
    
    private lazy var sellAllButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .systemBackground
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle(" 일괄매도 ", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        btn.addTarget(self, action: #selector(sellAllButtonClicked), for: .touchUpInside)
        return btn
    }()
    

    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    @objc func sellAllButtonClicked(){
        print("sellAllButtonClicked button clicked")
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
        [titleLabel, sellAllButton].forEach{
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        sellAllButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
//            $0.width.equalTo(80)
        }
    }
}
