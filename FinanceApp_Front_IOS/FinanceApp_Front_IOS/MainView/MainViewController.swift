//
//  MainViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import UIKit
import SnapKit
import SwiftUI
import Alamofire

class MainViewController: UIViewController {
    // 이곳에 왔을 때 UserDefaults에 저장된 항목 총 6가지
    // 1. appkey
    // 2. appsecret
    // 3. accessToken
    // 4. name
    // 5. acntNoFront
    // 6. acntNoBack
    
    //일간 차트
    private var dayDomesticPrice: [DomesticPrice] = []
    //일간 차트 종가
    private var dayDomesticClosePrice: [Double] = []
    
    //오늘의 Issue Stock 10개
    private var dayIssueStock: [String] = ["KeyStock 1", "KeyStock 2", "KeyStock 3", "KeyStock 4", "KeyStock 5", "KeyStock 6", "KeyStock 7", "KeyStock 8", "KeyStock 9", "KeyStock 10"]
    //오늘의 추천 Stock 10개
    private var dayRecomStock: [String] = ["RecomStock 1", "RecomStock 2", "RecomStock 3", "RecomStock 4", "RecomStock 5", "RecomStock 6", "RecomStock 7", "RecomStock 8", "RecomStock 9", "RecomStock 10"]
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 243/255.0, green: 146/255.0, blue: 156/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 40.0, weight: .heavy)
        label.text = "  KIS Finance Info"
        
        return label
    }()

    private lazy var myInfoUIView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        return uiView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 243/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 22.0, weight: .heavy)
        label.text = "  " + (UserDefaults.standard.string(forKey: "name") as? String ?? "이름없음") + "님 반갑습니다"
        
        return label
    }()
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 243/255.0, green: 176/255.0, blue: 176/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 22.0, weight: .heavy)
        label.text = "  " +  "계좌번호 : " + (UserDefaults.standard.string(forKey: "acntNoFront") as? String ?? "계좌없음") + "-" + (UserDefaults.standard.string(forKey: "acntNoBack") as? String ?? "계좌없음")
        
        return label
    }()
    
    // 주식 현재가
    private lazy var graphLabel: UILabel = {
        let label = UILabel()
        label.text = "주요 종목 차트"
        label.font = .systemFont(ofSize: 34.0, weight: .bold)
        label.textColor = UIColor(red: 233/255.0, green: 166/255.0, blue: 196/255.0, alpha: 1.0)
        return label
    }()
    
    private lazy var securityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "  한국금융지주  "
        label.layer.borderWidth = 4.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 6.0
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    private lazy var graphUIView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .black
        return uiView
    }()
    
    private lazy var chartHostingController: UIHostingController = {
        
        let hostingController = UIHostingController( rootView: KeywordChartSwiftUIView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], startDate: Date(), endDate: Date() ))
        
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }
//        hostingController.modalPresentationStyle = .popover
//        self.present(hostingController, animated: true)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        return hostingController
    }()
    
    
    private lazy var keyStockLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Issue Stock"
        label.font = .systemFont(ofSize: 34.0, weight: .bold)
        label.textColor = UIColor(red: 233/255.0, green: 166/255.0, blue: 196/255.0, alpha: 1.0)
        return label
    }()
    
    private lazy var keyStockCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 0
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true

        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    
    private lazy var recomStockLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's 추천종목"
        label.font = .systemFont(ofSize: 34.0, weight: .bold)
        label.textColor = UIColor(red: 233/255.0, green: 166/255.0, blue: 196/255.0, alpha: 1.0)
        return label
    }()
    
    private lazy var recomStockCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 1
        
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
//    let dateFormatter = DateFormatter()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("main와서 확인 ")
        print(UserDefaults.standard.string(forKey: "name"))
        print(UserDefaults.standard.string(forKey: "acntNoFront"))
        print(UserDefaults.standard.string(forKey: "acntNoBack"))
        
        layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        requestAPI_DomesticPrice_former()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            self.chartHostingController.view.snp.removeConstraints()
            self.chartHostingController = UIHostingController(rootView:  KeywordChartSwiftUIView(dailyData: self.dayDomesticClosePrice, startDate: Date(), endDate: Date()))
//            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
            
            if #available(iOS 16.0, *) {
                self.chartHostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }
            self.addChild(self.chartHostingController)
            self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
            self.graphUIView.addSubview(self.chartHostingController.view)
            
            self.chartHostingController.view.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
        }
        
        
    }
    

    private func layout(){
        
        [ scrollView ].forEach {
            view.addSubview($0)
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
            $0.width.equalToSuperview()
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        //
        [titleLabel, myInfoUIView,  graphLabel, securityNameLabel, graphUIView, keyStockLabel, keyStockCollectionView, recomStockLabel, recomStockCollectionView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(60)
        }
        
        myInfoUIView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        [nameLabel, accountLabel].forEach{
            myInfoUIView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        accountLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
//            $0.height.equalTo(60)
            $0.leading.equalToSuperview().inset(20)
        }
        
        graphLabel.snp.makeConstraints{
//            $0.top.equalTo(myInfoUIView.snp.bottom).offset(20)
            $0.height.equalTo(80)
            $0.leading.equalToSuperview().inset(20)
        }

        securityNameLabel.snp.makeConstraints{
//            $0.top.equalTo(graphLabel.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        graphUIView.snp.makeConstraints{
//            $0.top.equalTo(graphLabel.snp.bottom).offset(40)
            $0.height.equalTo(300)
            $0.leading.trailing.equalToSuperview()
        }
        
        keyStockLabel.snp.makeConstraints{
//            $0.top.equalTo(graphUIView.snp.bottom).offset(40)
            $0.height.equalTo(80)
            $0.leading.equalToSuperview().inset(20)
        }
        
        keyStockCollectionView.snp.makeConstraints{
//            $0.top.equalTo(graphUIView.snp.bottom).offset(40)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview()
        }
        
        recomStockLabel.snp.makeConstraints{
//            $0.top.equalTo(keyStockLabel.snp.bottom).offset(4)
            $0.height.equalTo(80)
            $0.leading.equalToSuperview().inset(20)
        }
        
        recomStockCollectionView.snp.makeConstraints{
//            $0.top.equalTo(keyStockLabel.snp.bottom).offset(4)
            $0.height.equalTo(140)
            $0.leading.equalToSuperview()
        }
    }
}


extension MainViewController {
    
    // 국내 주식 일자별 검색
    private func requestAPI_DomesticPrice_former(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-daily-price?FID_COND_MRKT_DIV_CODE=J&FID_INPUT_ISCD=071050&FID_PERIOD_DIV_CODE=D&FID_ORG_ADJ_PRC=0"
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "FHKST01010400"]
                   )
                .responseDecodable(of: DomesticPriceTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                    
                    self.dayDomesticPrice = data.output.map{ obj -> DomesticPrice in
                        let now = DomesticPrice(stck_bsop_date: obj.stck_bsop_date, stck_oprc: obj.stck_oprc, stck_hgpr: obj.stck_hgpr, stck_lwpr: obj.stck_lwpr, stck_clpr: obj.stck_clpr, acml_vol: obj.acml_vol, prdy_vrss_vol_rate: obj.prdy_vrss_vol_rate, prdy_vrss_sign: obj.prdy_vrss_sign, prdy_ctrt: obj.prdy_ctrt, frgn_ntby_qty: obj.frgn_ntby_qty)
                        return now
                    }
                    
                    self.dayDomesticClosePrice = data.output.map{ obj -> Double in
                        let now = Double(obj.stck_clpr) ?? 0.0
                        return now
                    }

                    //보유종목 부분 update
//                    self.securityNameCollectionView.reloadData()
//                    self.securityCollectionView.reloadData()
                    
        }.resume()
    }
    
}


// dayIssueStock
// dayRecomStock
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return self.dayIssueStock.count
        }else{
            return self.dayRecomStock.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView.tag == 0 {
            print("0에서")
            cell.setup(rank: String(indexPath.row + 1), stock: dayIssueStock[indexPath.row])
           
        } else {
            print("1에서")
            cell.setup(rank: String(indexPath.row + 1), stock: dayRecomStock[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 140)
    }
}
