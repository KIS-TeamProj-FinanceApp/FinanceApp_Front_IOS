//
//  MyAccountHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/23.
//

import UIKit

class MyAccountHeaderView: UIView {
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    private var titles: [String] = ["국내 주식잔고", "해외 주식잔고"]
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "국내 주식잔고"
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        return label
    }()
    
    private lazy var changeButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .systemBackground
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("  해외주식잔고  ", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        btn.addTarget(self, action: #selector(marketChange), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var refreshButton: UIButton = {
        let btn = UIButton()
//        btn.layer.cornerRadius = 3.0
//        btn.layer.borderWidth = 2.0
//        btn.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
//        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        btn.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
        return btn
    }()

    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    @objc func marketChange(){
        print("marketChange button clicked")
    }
    
    
    @objc func refreshButtonClicked(){
        print("refreshButtonClicked button clicked")
        NotificationCenter.default.post(name: .refreshMyAccount, object: nil)
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
        [titleLabel, changeButton, refreshButton].forEach{
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
//            $0.trailing.equalToSuperview().inset(UIScreen.main.bounds.size.width  / 2)
//            $0.centerX.equalToSuperview().inset(UIScreen.main.bounds.size.width / 3)
            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        changeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(60)
        }
        
        refreshButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
            $0.leading.equalTo(changeButton.snp.trailing).offset(10)
        }
    
    }
}

extension Notification.Name {
    static let refreshMyAccount = Notification.Name("refreshMyAccount")
}
