//
//  AccountExistenceViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//

import UIKit
import SnapKit


final class AccountExistenceViewController: UIViewController {
    
    
    private lazy var questionLabel: UILabel = {
        let qLabel = UILabel()
        
        qLabel.text = "한국투자증권 계좌를 갖고계신가요?"
        qLabel.font = UIFont.systemFont(ofSize: 22)
        return qLabel
    }()
    
    private lazy var accountYesButton: UIButton = {
        let button = UIButton()
       
        button.setTitle("계좌 있음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(yesAccount), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountNoButton: UIButton = {
        let button = UIButton()
        button.setTitle("계좌 없음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(noAccount), for: .touchUpInside)
        return button
    }()
    
    @objc func yesAccount(){
        print("yes")
        
        let vc = AppkeyExistenceViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func noAccount(){
        print("no")
        openAppStore()
    }
    
    private func openAppStore() {
        let url = "https://itunes.apple.com/app/"
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
       
    }
    
    
    private func callSafari(){
        guard let url = URL(string: "http://zeddios.tistory.com"),
                UIApplication.shared.canOpenURL(url) else { return }

         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
    }
    
    
    private func attribute(){
        
    }
    
    private func layout(){
        
        [questionLabel, accountYesButton, accountNoButton].forEach{
            view.addSubview($0)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountYesButton.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountNoButton.snp.makeConstraints{
            $0.top.equalTo(accountYesButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
