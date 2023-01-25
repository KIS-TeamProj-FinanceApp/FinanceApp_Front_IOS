//
//  glHalfView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//

import UIKit

class glHalfView: UIView {
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var title1Label: UILabel = {
        let label = UILabel()
        label.text = "항목1"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var title1ValueLabel: UILabel = {
        let label = UILabel()
        label.text = "항목1 내용"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var title2Label: UILabel = {
        let label = UILabel()
        label.text = "항목2"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var title2ValueLabel: UILabel = {
        let label = UILabel()
        label.text = "항목2 내용"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    

    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    @objc func marketChange(){
        print("marketChange button clicked")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 223/255.0, green: 186/255.0, blue: 120/255.0, alpha: 1.0)
       
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [title1Label, title1ValueLabel, title2Label, title2ValueLabel].forEach{
            self.addSubview($0)
        }
        
        title1Label.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        title1ValueLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(title1Label.snp.trailing)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        title2Label.snp.makeConstraints{
            $0.top.equalTo(title1Label.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        title2ValueLabel.snp.makeConstraints{
            $0.top.equalTo(title1Label.snp.bottom).offset(12)
            $0.leading.equalTo(title2Label.snp.trailing)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setupTitle(title1: String, title2: String){
        self.title1Label.text = title1
        self.title2Label.text = title2
    }
    
    func setupValue(value1: String, value2: String) {
        self.title1ValueLabel.text = value1
        self.title2ValueLabel.text = value2
    }
}
