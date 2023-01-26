//
//  MainViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import UIKit


class MainViewController: UIViewController {
    
    
  
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Main화면"
        
        return label
    }()
    
    private lazy var tempLabel2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = (UserDefaults.standard.string(forKey: "name") as? String ?? "이름없음") + "님 반갑습니다"
        
        return label
    }()
    private lazy var tempLabel3: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "계좌번호 : " + (UserDefaults.standard.string(forKey: "acntNoFront") as? String ?? "계좌없음") + "-" + (UserDefaults.standard.string(forKey: "acntNoBack") as? String ?? "계좌없음")
        
        return label
    }()
    
    
   
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        attribute()
        layout()
    }
    
    
    
    private func attribute(){

    }
    

    private func layout(){
        [ tempLabel, tempLabel2, tempLabel3].forEach{
            view.addSubview($0)
        }

        tempLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        tempLabel2.snp.makeConstraints{
            $0.top.equalTo(tempLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        tempLabel3.snp.makeConstraints{
            $0.top.equalTo(tempLabel2.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
