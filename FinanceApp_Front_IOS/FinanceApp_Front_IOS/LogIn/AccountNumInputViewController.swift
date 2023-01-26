//
//  AccountNumInputViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import UIKit
import SnapKit
import Alamofire

final class AccountNumInputViewController: UIViewController {
    
    
    //이곳에서는 appkey, appsecretkey, accesstoken은 모두 UserDefaults에 저장된 상황이어야한다.
    
    private var name: String = "양준식"
    //계좌번호 앞 8자리
    private var accountNoFront8: String = "73085780"
    // 계좌번호 뒷 2자리
    private var accountNoBack2: String = "01"

    private var myAccount: MoneyObject?
    
    
//    private lazy var questionLabel: UILabel = {
//        let qLabel = UILabel()
//
//        qLabel.text = "계좌번호 & 이름 입력"
//        qLabel.font = UIFont.systemFont(ofSize: 22)
//        return qLabel
//    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "이름 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    
    private lazy var accountNumFrontLabel: UILabel = {
        let label = UILabel()
        label.text = "계좌번호 앞 8자리"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    private lazy var accountNumFrontTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "계좌번호 앞 8자리 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    
    private lazy var accountNumBackLabel: UILabel = {
        let label = UILabel()
        label.text = "계좌번호 뒷 2자리"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    private lazy var accountNumBackTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "계좌번호 뒷 2자리 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("계좌 불러오기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 195/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
        return button
    }()
    
    private lazy var nosendButton: UIButton = {
        let button = UIButton()
        button.setTitle("계좌정보 채우기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(fillInfo), for: .touchUpInside)
        return button
    }()
    
    
//    private lazy var textfield: UITextField = {
//        let textField = UITextField()
//        textField.layer.borderWidth = 1.0
//        textField.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
//        textField.layer.cornerRadius = 6.0
//        textField.textColor = .black
//        textField.placeholder = "여기에 입력해주세요"
//        return textField
//    }()
    
    @objc func getToken(){
        print("토큰 발급받기")

        requestAPI()
        
        DispatchQueue.main.async {
            let vc = MainTabBarController()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            windowScene.windows.first?.rootViewController = vc
        }
    }
    @objc func fillInfo(){
        self.nameTextField.text = self.name
        self.accountNumFrontTextField.text = self.accountNoFront8
        self.accountNumBackTextField.text = self.accountNoBack2
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("저장되었는지 확인")
        print(UserDefaults.standard.string(forKey: "appkey")!)
        print(UserDefaults.standard.string(forKey: "appsecret")!)
        print(UserDefaults.standard.string(forKey: "accessToken")!)
        
        UserDefaults.standard.set(self.name, forKey: "name")
        UserDefaults.standard.set(self.accountNoFront8, forKey: "acntNoFront")
        UserDefaults.standard.set(self.accountNoBack2, forKey: "acntNoBack")
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        //navigation 이름설정
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "계좌번호 & 이름 입력"
        
//        let accessToken: String = UserDefaults.standard.string(forKey: "accessToken")!
//        self.textfield.text = accessToken
    }
    
    
    private func attribute(){
        
    }
    
    private func layout(){
        
        [nameLabel, nameTextField, accountNumFrontLabel, accountNumFrontTextField, accountNumBackLabel, accountNumBackTextField, sendButton, nosendButton].forEach{
            view.addSubview($0)
        }
        
//        questionLabel.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
//            $0.leading.trailing.equalToSuperview().inset(30)
//        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        nameTextField.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        accountNumFrontLabel.snp.makeConstraints{
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountNumFrontTextField.snp.makeConstraints{
            $0.top.equalTo(accountNumFrontLabel.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountNumBackLabel.snp.makeConstraints{
            $0.top.equalTo(accountNumFrontTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        accountNumBackTextField.snp.makeConstraints{
            $0.top.equalTo(accountNumBackLabel.snp.bottom).offset(8)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        sendButton.snp.makeConstraints{
            $0.top.equalTo(accountNumBackTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        nosendButton.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
//        textfield.snp.makeConstraints{
//            $0.top.equalTo(nosendButton.snp.bottom).offset(20)
//            $0.height.equalTo(300)
//            $0.leading.trailing.equalToSuperview().inset(30)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



extension AccountNumInputViewController {

    private func requestAPI(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/inquire-balance?CANO=73085780&ACNT_PRDT_CD=01&AFHR_FLPR_YN=N&OFL_YN&INQR_DVSN=02&UNPR_DVSN=01&FUND_STTL_ICLD_YN=Y&FNCG_AMT_AUTO_RDPT_YN=N&PRCS_DVSN=00&CTX_AREA_FK100&CTX_AREA_NK100"
        
        print("지금 만든 url = " + (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "") )
        print("access Token = " + UserDefaults.standard.string(forKey: "accessToken")!)
        print("appkey = " + UserDefaults.standard.string(forKey: "appkey")!)
        print("appServiceKey = " + UserDefaults.standard.string(forKey: "appsecret")!)
        print()
        print()
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": String(UserDefaults.standard.string(forKey: "accessToken")!) ,
                                             "appkey": String(UserDefaults.standard.string(forKey: "appkey")!),
                                             "appsecret": String(UserDefaults.standard.string(forKey: "appsecret")!),
                                             "tr_id": "TTTC8434R"]
                   )
        .response(){ [weak self] response in
            guard
                let self = self,
                case .success(let data) = response.result else { return }
                UserDefaults.standard.set(self.name, forKey: "name")
                UserDefaults.standard.set(self.accountNoFront8, forKey: "acntNoFront")
                UserDefaults.standard.set(self.accountNoBack2, forKey: "acntNoBack")
                print(data)

//                    self.textfield.text = (self.myAccount?.totalMoney ?? "계좌잔액 불러오지못함") + (self.myAccount?.oneDayBeforeMoney ?? "전일 계좌잔액 없음")
        }.resume()
        
        
        
//                .responseDecodable(of: MyAccountDto.self){ [weak self] response in
//                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
//                                guard
//                                    let self = self,
//                                    case .success(let data) = response.result else {
//                                    print("못함.... response는")
//                                    print(response)
//
//                                    return }
//
//                    UserDefaults.standard.set(self.name, forKey: "name")
//                    UserDefaults.standard.set(self.accountNoFront8, forKey: "acntNoFront")
//                    UserDefaults.standard.set(self.accountNoBack2, forKey: "acntNoBack")
//                    self.myAccount = MoneyObject(totalMoney: data.moneyObjectArr[0].totalMoney)
//
////                    self.textfield.text = (self.myAccount?.totalMoney ?? "계좌잔액 불러오지못함") + (self.myAccount?.oneDayBeforeMoney ?? "전일 계좌잔액 없음")
//
//        }.resume()
        
    }
}
