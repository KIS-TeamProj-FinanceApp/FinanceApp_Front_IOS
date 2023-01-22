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
    
    private lazy var questionLabel: UILabel = {
        let qLabel = UILabel()
        
        qLabel.text = "appkey와 appservicekey를 입력해주세요"
        qLabel.font = UIFont.systemFont(ofSize: 22)
        return qLabel
    }()
    
    private lazy var appKeyLabel: UILabel = {
        let label = UILabel()
        label.text = "AppKey"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var appKeyTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
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
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    private lazy var appServiceKeyTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 210/255, alpha: 1).cgColor
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
        button.setTitle("OAuth 접근토큰 발급", for: .normal)
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
        button.setTitle("OAuth 접근토큰 발급 안된 경우", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 255/255.0, green: 222/255.0, blue: 194/255.0, alpha: 1.0)
        button.layer.borderColor = UIColor(red: 153/255.0, green: 76/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(getToken), for: .touchUpInside)
        return button
    }()
    
    
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
        postTest()
        
        print("화면 띄우기 전")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            print("화면 띄우기! dispatchQueue에 들어옴")
            print("차트 조회 버튼 클릭")
           
            let vc = AccountNumInputViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
//        let vc = AppkeyExistenceViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
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
        
        [questionLabel, appKeyLabel, appKeyTextField, appServiceKeyLabel, appServiceKeyTextField, sendButton, nosendButton, textfield].forEach{
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
        
        appKeyTextField.snp.makeConstraints{
            $0.top.equalTo(appKeyLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        
        appServiceKeyLabel.snp.makeConstraints{
            $0.top.equalTo(appKeyTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        appServiceKeyTextField.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        sendButton.snp.makeConstraints{
            $0.top.equalTo(appServiceKeyTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        nosendButton.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        textfield.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(20)
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
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
                //AccessToken을 UserDefaults에 저장한다.
                //appkey, appServiceKey를 UserDefaults에 저장함
                
                UserDefaults.standard.set(self.appKey, forKey: "appkey")
                UserDefaults.standard.set(self.appSecretKey, forKey: "appSecretKey")
                
                UserDefaults.standard.set("Bearer " + (self.accessToken?.access_token ?? ""), forKey: "accessToken")
                
                print("저장 끝 UserDefaults")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//                    print("정보 다 받아왔나?")
//                    print("차트 조회 버튼 클릭")
//                    // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
//
//                    let hostingController = UIHostingController(rootView: SwiftUIChartView(title: self.itemNmTextField.text ?? "종목 이름 오류", securityArr: self.securityInfoArr, mkpInfoArr: self.mkpInfoArr, clprInfoArr: self.clprInfoArr, hiprInfoArr: self.hiprInfoArr, loprInfoArr: self.loprInfoArr))
//                    if #available(iOS 16.0, *) {
//                        hostingController.sizingOptions = .preferredContentSize
//                    } else {
//                        // Fallback on earlier versions
//                    }
//                    hostingController.modalPresentationStyle = .popover
//                    self.present(hostingController, animated: true)
//                }

                
                self.textfield.text = (self.accessToken?.access_token ?? "no access_token\n token_type = \n") + (self.accessToken?.token_type ?? "no token_type!")
                
            }.resume()
        
//        AF.request(request).response(){
//            [weak self] response in
//            guard
//                let self = self,
//                case .success(let data) = response.result else { return }
//
//            let str = String(decoding: data!, as: UTF8.self)
//
//            print(type(of:str))
//
//            print("내용내용내용")
//            print(str)
//            self.textfield.text = str
//
//        }.resume()
        
        
        
        
        
    }

//

//    private func requestAPI(){
//        let url = "https://openapi.koreainvestment.com:9443/oauth2/tokenP"
////        let url = self.apiUrl
//        //addingPercentEncoding은 한글(영어 이외의 값) 이 url에 포함되었을 때 오류나는 것을 막아준다.
//
//        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
//            .response(){ [weak self] response in
//                guard
//                    let self = self,
//                    case .success(let data) = response.result else { return }
//                //str이, 받아온 json을 형태 그대로 STring으로 만든 것이다.
//                let str = String(decoding: data!, as: UTF8.self)
//                self.apiResultStr = str
//                self.jsonResultArr = JsonParser.jsonToArr(jsonString: str)
//                print(self.jsonResultArr)
//                self.isClickedArr_col = Array(repeating: false, count: self.jsonResultArr[0].count)
//                self.isClickedArr_row = Array(repeating: false, count: self.jsonResultArr.count - 1)
//
////                //테이블 뷰 다시 그려줌
//                self.collectionView.isHidden = false
//                self.collectionView.reloadData()
//            }
//            .resume()
//    }
    
    
}