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
    
    private var isOverseas: Bool = true
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private lazy var redUIView: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        uiview.layer.borderWidth = 1.0
        uiview.layer.borderColor = UIColor.lightGray.cgColor
        uiview.layer.cornerRadius = 4.0
        return uiview
    }()
    
    
    private lazy var overseasButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("해외", for: .normal)
        //이렇게 두가지를 선택/해제시에 바꿔줌
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        //이렇게 두가지를 선택/해제시에 바꿔줌
        btn.layer.cornerRadius = 6.0
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(overseasButtonClicked), for: .touchUpInside)
        return btn
    }()
    @objc func overseasButtonClicked(){
        print("해외 버튼 클릭")
        if self.isOverseas{
            return
        }else{
            self.isOverseas = true
            overseasButton.layer.borderWidth = 3.0
            overseasButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
            
            domesticButton.layer.borderWidth = 1.0
            domesticButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        }
    }
    
    private lazy var domesticButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("국내", for: .normal)
        //이렇게 두가지를 선택/해제시에 바꿔줌
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        //이렇게 두가지를 선택/해제시에 바꿔줌
        btn.layer.cornerRadius = 6.0
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(domesticButtonClicked), for: .touchUpInside)
        return btn
    }()
   
    @objc func domesticButtonClicked(){
        print("국내 버튼 클릭")
        if self.isOverseas{
            self.isOverseas = false
            domesticButton.layer.borderWidth = 3.0
            domesticButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
            
            overseasButton.layer.borderWidth = 1.0
            overseasButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        }else{
            return
        }
        
    }
    private lazy var securityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목명  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var securityValueLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "종목명 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var tickerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목코드  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var tickerValueLabel: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "종목코드 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
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
        btn.addTarget(self, action: #selector(domesticBuyStockClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc func domesticBuyStockClicked(){
        print("호출!")
        
//        domesticBuyStock()
    }
    
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
        label.text = "수량  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var quantityTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "수량 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var formulaLabel: UILabel = {
        let label = UILabel()
        label.text = "호가  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var formulaTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "호가방식 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var designatedLabel: UILabel = {
        let label = UILabel()
        label.text = "지정가  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var designatedTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "지정가 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    //가운데 border 바
    let borderView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
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
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.isOverseas = true
        self.overseasButton.layer.borderWidth = 3.0
        self.overseasButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        self.domesticButton.layer.borderWidth = 1.0
        self.domesticButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        
        
    }
    

    private func layout(){
        
        [redUIView,  securityNameLabel, securityValueLabel, tickerNameLabel, tickerValueLabel, buyButton, sellButton, quantityLabel, quantityTextField, formulaLabel, formulaTextField, designatedLabel, designatedTextField].forEach{
            view.addSubview($0)
        }
        
        redUIView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        [borderView, overseasButton, domesticButton ].forEach{
            redUIView.addSubview($0)
        }
        borderView.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.width.equalTo(2)
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalToSuperview()
        }
        
        overseasButton.snp.makeConstraints{
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 50)
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(borderView.snp.leading).offset(-10)
        }

        domesticButton.snp.makeConstraints{
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 50)
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(borderView.snp.trailing).offset(10)
        }
        
    

        securityNameLabel.snp.makeConstraints{
            $0.top.equalTo(redUIView.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        securityValueLabel.snp.makeConstraints{
            $0.top.equalTo(redUIView.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tickerNameLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        tickerValueLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        buyButton.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 20)
            $0.leading.equalToSuperview().inset(10)
        }
        
        sellButton.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 20)
            $0.leading.equalTo(buyButton.snp.trailing).offset(20)
        }
        
        quantityLabel.snp.makeConstraints{
            $0.top.equalTo(buyButton.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        quantityTextField.snp.makeConstraints{
            $0.top.equalTo(buyButton.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        formulaLabel.snp.makeConstraints{
            $0.top.equalTo(quantityLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        formulaTextField.snp.makeConstraints{
            $0.top.equalTo(quantityLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        designatedLabel.snp.makeConstraints{
            $0.top.equalTo(formulaLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        designatedTextField.snp.makeConstraints{
            $0.top.equalTo(formulaLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
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


extension WBTradeViewController{
    // 국내주식 매수
    private func domesticBuyStock(){
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6ImRiMzA5YzNjLTg1YzItNGU1NC05MGY3LThhNmQ0MDI1MjljMyIsImlzcyI6InVub2d3IiwiZXhwIjoxNjc0NzEwNTY3LCJpYXQiOjE2NzQ2MjQxNjcsImp0aSI6IlBTYnJpOVQyOThWeXhmSjAwNHg5TW5DUW54N2dLSlI4djY1OCJ9.Y985_sfMXWY9k1G-36kefExOCoLP_WydM7oUiHjayC6kdpikxkW0e84akuxJZmtibSIm46B9Bwg4oaZUYzR8bA", forHTTPHeaderField: "authorization")
        request.setValue("PSbri9T298VyxfJ004x9MnCQnx7gKJR8v658", forHTTPHeaderField: "appkey")
        request.setValue("VUn2CzaKPT1oTzwfBiXlY2ASg8SEndHMk/h5ukdZOElQVP5dfnfnv3OiTqw3aKYGR1NRYg17q05zOFlFhW8CdwYzMPI2wmqB9cNgx2f03O1ROveEw6Kr/CeGojxZBPMVU2MMzun4Gapcq1zu+lWYhbkDK/fAfmeCD+ftD2WMWPrJw9UBG0c=", forHTTPHeaderField: "appsecret")
        request.setValue("TTTC0802U", forHTTPHeaderField: "tr_id")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["CANO":"73085780", "ACNT_PRDT_CD":"01", "PDNO":"036630", "ORD_DVSN":"01", "ORD_QTY":"1", "ORD_UNPR":"0"] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).response(){ [weak self] response in
            guard
                let self = self,
                case .success(let data) = response.result else { return }
            //str이, 받아온 json을 형태 그대로 STring으로 만든 것이다.
           print("받은 응답 = ")
            let str = String(decoding: data!, as: UTF8.self)
            print(str)
            self.navigationController?.dismiss(animated: true)
        }
        .resume()
    }
    
    // 국내주식 매도
    private func domesticSellStock(){
        
    }
    
    // 해외주식 매수
    private func overSeasBuyStock(){
        
    }
    
    // 해외주식 매도
    private func overSeasSellStock(){
        
    }
}
