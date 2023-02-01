//
//  AppkeyInputViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/18.
//

import UIKit
import SnapKit
import Alamofire

final class AppkeyInputViewController: UIViewController {
    
    //처음에는 accessToken이 없으니까 nil로 시작한다.
    private var accessToken: AccessToken? = nil
    
    
    private var appKey: String = "PSbri9T298VyxfJ004x9MnCQnx7gKJR8v658"
    private var appSecretKey: String = "VUn2CzaKPT1oTzwfBiXlY2ASg8SEndHMk/h5ukdZOElQVP5dfnfnv3OiTqw3aKYGR1NRYg17q05zOFlFhW8CdwYzMPI2wmqB9cNgx2f03O1ROveEw6Kr/CeGojxZBPMVU2MMzun4Gapcq1zu+lWYhbkDK/fAfmeCD+ftD2WMWPrJw9UBG0c="
    
    
    private lazy var questionTextField: UITextField = {
        let tv = UITextField()
        
        tv.text = "appkey와 appservicekey를"
        tv.font = .systemFont(ofSize: 22.0, weight: .semibold)
//        tv.textAlignment = .natural
        return tv
    }()
    private lazy var questionTextField2: UITextField = {
        let tv = UITextField()
        
        tv.text = "입력해주세요"
        tv.font = .systemFont(ofSize: 22.0, weight: .semibold)
//        tv.textAlignment = .natural
        return tv
    }()
    
    private lazy var appKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "AppKey"
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        return label
    }()
    
    private lazy var appKeyTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "AppKey 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    
    private lazy var appServiceKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "AppServiceKey"
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        return label
    }()
    
    
    private lazy var appServiceKeyTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        tf.layer.cornerRadius = 8.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "AppServiceKey 입력"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 토큰 발급", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 253/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 253/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
        return button
    }()
    
//    private lazy var nosendButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("두가지key 채우기", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = UIColor(red: 255/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
//        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
//        button.layer.borderWidth = 1.0
//        button.layer.cornerRadius = 8.0
//        button.addTarget(self, action: #selector(fillTextField), for: .touchUpInside)
//        return button
//    }()
    
    
    private lazy var textfield: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        textField.layer.cornerRadius = 6.0
        textField.textColor = .black
        textField.placeholder = "여기에 입력해주세요"
        return textField
    }()
    
    @objc func getToken(){
        print("토큰 발급받기")
        self.appKeyTextField.text = self.appKey
        self.appServiceKeyTextField.text = self.appSecretKey
        postTest()
        
        print("화면 띄우기 전")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            print("화면 띄우기! dispatchQueue에 들어옴")
            print("차트 조회 버튼 클릭")
           
            let vc = AccountNumInputViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func fillTextField(){
        self.appKeyTextField.text = self.appKey
        self.appServiceKeyTextField.text = self.appSecretKey
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
        view.backgroundColor = .white
        
    }
    
    
    private func attribute(){
        
    }
    
    private func layout(){
        
        [questionTextField, questionTextField2, appKeyLabel, appKeyTextField, appServiceKeyLabel, appServiceKeyTextField, sendButton].forEach{
            view.addSubview($0)
        }
        
        questionTextField.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        questionTextField2.snp.makeConstraints{
            $0.top.equalTo(questionTextField.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        appKeyLabel.snp.makeConstraints{
            $0.top.equalTo(questionTextField2.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        appKeyTextField.snp.makeConstraints{
            $0.top.equalTo(appKeyLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        
        appServiceKeyLabel.snp.makeConstraints{
            $0.top.equalTo(appKeyTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        appServiceKeyTextField.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        sendButton.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyTextField.snp.bottom).offset(50)
            $0.height.equalTo(36)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
//        nosendButton.snp.makeConstraints{
//            $0.top.equalTo(sendButton.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(30)
//        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



extension AppkeyInputViewController {
    
    private func postTest(){

        let url = "https://openapi.koreainvestment.com:9443/oauth2/tokenP"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["grant_type":"client_credentials", "appkey":"PSbri9T298VyxfJ004x9MnCQnx7gKJR8v658", "appsecret":"VUn2CzaKPT1oTzwfBiXlY2ASg8SEndHMk/h5ukdZOElQVP5dfnfnv3OiTqw3aKYGR1NRYg17q05zOFlFhW8CdwYzMPI2wmqB9cNgx2f03O1ROveEw6Kr/CeGojxZBPMVU2MMzun4Gapcq1zu+lWYhbkDK/fAfmeCD+ftD2WMWPrJw9UBG0c="] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request)
            .responseDecodable(of: AccessTokenDto.self){ [weak self] response in
                
                guard
                    let self = self,
                    case .success(let data) = response.result else {
                    print("실패,,,")
                    return }
                
                // 성공하여 access token을 받아왔을 경우
                self.accessToken = AccessToken(access_token: data.access_token!, token_type: data.token_type!, expires_in: data.expires_in!)
                
                print()
                print()
                print("지금의 accessToken은 ")
                print(self.accessToken?.access_token ?? "토큰 없음")
                print()
                print()
                
                
                print("저장 시작 UserDefaults")

                UserDefaults.standard.set(self.appKey, forKey: "appkey")
                UserDefaults.standard.set(self.appSecretKey, forKey: "appsecret")
                
                UserDefaults.standard.set("Bearer " + (self.accessToken?.access_token ?? ""), forKey: "accessToken")
                
                print("저장 끝 UserDefaults")

                
            }.resume()
    
        
    }
    
}
