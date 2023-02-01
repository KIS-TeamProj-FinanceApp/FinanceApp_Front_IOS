//
//  AppkeyExistenceViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//


import UIKit
import SnapKit


final class AppkeyExistenceViewController: UIViewController {
    
    
    private lazy var questionTextField: UITextField = {
        let tv = UITextField()
        
        tv.text = "한국투자증권 Developers에서"
        tv.font = UIFont.systemFont(ofSize: 22)
//        tv.textAlignment = .natural
        return tv
    }()
    private lazy var questionTextField2: UITextField = {
        let tv = UITextField()
        
        tv.text = "appkey와 appservicekey를"
        tv.font = UIFont.systemFont(ofSize: 20)
//        tv.textAlignment = .natural
        return tv
    }()
    private lazy var questionTextField3: UITextField = {
        let tv = UITextField()
        
        tv.text = "발급받으세요"
        tv.font = UIFont.systemFont(ofSize: 20)
//        tv.textAlignment = .natural
        return tv
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
        button.backgroundColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(goKISDevelopers), for: .touchUpInside)
        return button
    }()
    
    private lazy var accountNoButton: UIButton = {
        let button = UIButton()
        button.setTitle("발급 받았음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(alreadyDid), for: .touchUpInside)
        return button
    }()
    
    @objc func goKISDevelopers(){
        print("goKISDevelopers")
        openSafariApp()
    }
    
    @objc func alreadyDid(){
        print("발급 이미 받았음")
        let vc = AppkeyInputViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.questionTextField.isEnabled = false
        self.questionTextField2.isEnabled = false
        self.questionTextField3.isEnabled = false
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    @objc private func openSafariApp() {
        guard let appleUrl = URL(string: "https://apiportal.koreainvestment.com/")   else { return }
        guard UIApplication.shared.canOpenURL(appleUrl)             else { return }

        UIApplication.shared.open(appleUrl, options: [:], completionHandler: nil)
    }
    
   
    
    private func layout(){
        
        [questionTextField, questionTextField2, questionTextField3, appKeyLabel, appServiceKeyLabel, accountYesButton, accountNoButton].forEach{
            view.addSubview($0)
        }
        
        questionTextField.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        questionTextField2.snp.makeConstraints{
            $0.top.equalTo(questionTextField.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        questionTextField3.snp.makeConstraints{
            $0.top.equalTo(questionTextField2.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        appKeyLabel.snp.makeConstraints{
            $0.top.equalTo(questionTextField3.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        appServiceKeyLabel.snp.makeConstraints{
            $0.top.equalTo(appKeyLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        accountYesButton.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyLabel.snp.bottom).offset(50)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(40)
           
        }
        
        accountNoButton.snp.makeConstraints{
            $0.top.equalTo(accountYesButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
    }
}
