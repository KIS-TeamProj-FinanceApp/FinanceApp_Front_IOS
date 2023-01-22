//
//  WBTradeViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit
import Alamofire

class WBTradeViewController: UIViewController {
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    private var nowSecurity: SecurityForRecommend?
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
   
    private lazy var securityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목명"
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var securityValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var tickerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목코드"
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var tickerValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = .white
        
        btn.setTitle("매수", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        return btn
    }()
    
    private lazy var sellButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 3.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 0/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = .white
        btn.setTitle("매도", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        return btn
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "수량 : "
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var quantityTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.magenta.cgColor
        tf.layer.cornerRadius = 6.0
        return tf
    }()
    
    private lazy var formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "호가 : "
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.magenta.cgColor
        label.layer.cornerRadius = 6.0
        return label
    }()
    
    private lazy var formulaTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.magenta.cgColor
        tf.layer.cornerRadius = 6.0
        return tf
    }()
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationBar 숨기기는 viewDidLoad에서 해줘야한다.
        self.navigationController?.isNavigationBarHidden = true
        attribute()
        layout()
    }
    
    private func attribute(){
        
    }

    private func layout(){
        [securityNameLabel, securityValueLabel, tickerNameLabel, tickerValueLabel, buyButton, sellButton, quantityLabel, quantityTextField, formulaLabel, formulaTextField].forEach{
            view.addSubview($0)
        }

        securityNameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        securityValueLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.top)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(securityNameLabel.snp.trailing).offset(30)
        }
        
        tickerNameLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        tickerValueLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(tickerNameLabel.snp.trailing).offset(30)
        }
        
        buyButton.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 20)
            $0.leading.equalToSuperview().inset(10)
        }
        
        sellButton.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 20)
            $0.leading.equalTo(buyButton.snp.trailing).offset(20)
        }
        
        quantityLabel.snp.makeConstraints{
            $0.top.equalTo(buyButton.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        quantityTextField.snp.makeConstraints{
            $0.top.equalTo(buyButton.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(quantityLabel.snp.trailing).offset(30)
        }
        
        formulaLabel.snp.makeConstraints{
            $0.top.equalTo(quantityLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        formulaTextField.snp.makeConstraints{
            $0.top.equalTo(quantityLabel.snp.bottom).offset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(formulaLabel.snp.trailing).offset(30)
        }
    }
    
    func setup(security: SecurityForRecommend){
        self.nowSecurity = security
        securityValueLabel.text = security.securityName
        tickerValueLabel.text = security.sector
    }
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}
