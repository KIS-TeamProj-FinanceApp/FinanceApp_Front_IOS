//
//  AppkeyExistenceViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//


import UIKit
import SnapKit


final class AppkeyExistenceViewController: UIViewController {
    
    
    private lazy var questionLabel: UILabel = {
        let qLabel = UILabel()
        
        qLabel.text = "한국투자증권 Developers에서 appkey와 appservicekey를 발급받으세요"
        qLabel.font = UIFont.systemFont(ofSize: 22)
        return qLabel
    }()
    
    private lazy var appKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "1. appkey 발급"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var appServiceKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "2. appServiceKey 발급"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var accountYesButton: UIButton = {
        let button = UIButton()
       
        button.setTitle("발급 받으러 가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(goKISDevelopers), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountNoButton: UIButton = {
        let button = UIButton()
        button.setTitle("발급 받았음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(alreadyDid), for: .touchUpInside)
        return button
    }()
    
    @objc func goKISDevelopers(){
        print("goKISDevelopers")
    }
    
    @objc func alreadyDid(){
        print("발급 이미 받았음")
        let vc = AppkeyInputViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        [questionLabel, appKeyLabel, appServiceKeyLabel, accountYesButton, accountNoButton].forEach{
            view.addSubview($0)
        }
        
        questionLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        appKeyLabel.snp.makeConstraints{
            $0.top.equalTo(questionLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        appServiceKeyLabel.snp.makeConstraints{
            $0.top.equalTo(appKeyLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        accountYesButton.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountNoButton.snp.makeConstraints{
            $0.top.equalTo(accountYesButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
}