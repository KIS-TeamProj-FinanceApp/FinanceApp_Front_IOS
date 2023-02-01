//
//  MyAccountViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit
import Alamofire
import SwiftUI

class MyAccountViewController: UIViewController {

    private var myAccountSecurities: [MyAccountSecurities] = [MyAccountSecurities(prdt_name: "", pdno: "", evlu_pfls_amt: "", evlu_pfls_rt: "", evlu_amt: "", hldg_qty: "", pchs_amt: "", pchs_avg_pric: "", prpr: "", fltt_rt: "", thdt_buyqty: "", thdt_sll_qty: "")]
    //배열에 하나밖에 안 나옴 어차피
    private var myAccountMoney: [MyAccountMoney] = [MyAccountMoney(evlu_pfls_smtl_amt: "", dnca_tot_amt: "", d2_auto_rdpt_amt: "", scts_evlu_amt: "", pchs_amt_smtl_amt: "")]
    private var domesticTotalSuikRyul: String = "0.00%"
    
    //해외용
    private var myOverseasSecurities: [MyOverseasSecurities] = []
    //배열에 하나밖에 안 나옴 어차피
    private var myOverseasMoney: MyOverseasMoney? = nil
    
    
    // 체결내역 - 국내
    private var myDomesticAgreement: [DomesticAgreementDetail] = [DomesticAgreementDetail(prdt_name: "", sll_buy_dvsn_cd_name: "", sll_buy_dvsn_cd: "", ord_qty: "", avg_prvs: "", tot_ccld_qty: "", tot_ccld_amt: "", ord_dvsn_cd: "", odno: "", ord_dt: "", ord_tmd: "")]
    
    //체결내역 - 해외
    private var myOverseasAgreement: [OverseasAgreementDetail] = [OverseasAgreementDetail(prdt_name: "", sll_buy_dvsn_cd_name: "", sll_buy_dvsn_cd: "", ft_ord_qty: "", ft_ccld_unpr3: "", ft_ccld_qty: "", ft_ccld_amt3: "", odno: "", ord_dt: "", ord_tmd: "")]
    
    //업종 계산하여 놓을 곳
    private var myDomesticSectors: [String: Double] = [:]
    private var myOverseasSectors: [String: Double] = [:]
    
    
    private var isDomestic: Bool = true
    //주식잔고 선택한 것
    private var isBalance: Bool = true
    // 종목별 선택한 것
    private var isSector: Bool = true
   
    //계좌 관련 columns
    private let myAccountColumns: [String] = ["종목명", "종목코드", "평가손익", "수익률" ,"평가금액", "보유수량", "매입금액", "매입단가", "현재가", "등락률", "금일매수", "금일매도"]
    private let myOverseasColumns: [String] = ["종목명", "종목코드", "평가손익", "수익률" ,"평가금액", "보유수량", "매입금액", "매입단가", "현재가", "거래시장"]
    
    // 체결내역 관련
    private let myDomesticAgreementColumns: [String] = ["종목명", "매매구분", "구분", "주문수량" ,"체결평균", "체결수량", "총결제금", "주문구분", "주문번호", "주문일", "주문시간"]
    private let myOverseasAgreementColumns: [String] = ["종목명", "매매구분", "구분", "주문수량" ,"체결평균", "체결수량", "총결제금", "주문번호", "주문일", "주문시간"]

    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private let myAccountHeader = MyAccountHeaderView()
    
    private lazy var accountNumButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.backgroundColor = .systemBackground
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("  73085780-01 위탁(국내수수료우대), 양준식  ", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        btn.addTarget(self, action: #selector(accountNumClicked), for: .touchUpInside)
        return btn
    }()
    
    //주식 잔고
    private lazy var balanceButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("주식잔고", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        btn.addTarget(self, action: #selector(balanceButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    // 체결 내역
    private lazy var agreementButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("체결내역", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        btn.addTarget(self, action: #selector(agreementButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var balanceButtonBottom: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    private lazy var agreementButtonBottom: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        return btn
    }()
    
    //scrollView
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .systemBrown
        return stackView
    }()
    
    private let glView = GainsAndLossesView()
    
    private let moneyHorizontalView = MyAccountMoneyView()
       
    let borderView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        return v
    }()
    
    // 종목별
    private lazy var stockButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.borderWidth = 3.0
        btn.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 6.0
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("종목별", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        btn.addTarget(self, action: #selector(stockButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    // 업종별
    private lazy var sectorButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        btn.layer.cornerRadius = 6.0
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("업종별", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        btn.addTarget(self, action: #selector(sectorButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stockSectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .white
        return stackView
    }()
    
    
    
    
    private let portfolioView = PortfolioView()
    
    private lazy var cvStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var securityNameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 0
        
        collectionView.register(SecurityNameCollectionViewCell.self, forCellWithReuseIdentifier: "SecurityNameCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false

        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var securityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 1
        
        collectionView.register(SecurityCollectionViewCell.self, forCellWithReuseIdentifier: "SecurityCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true

        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    
    private lazy var sectorUIView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPink

        
        return view
    }()
    
    
    
    
    private let agreementScrollView = UIScrollView()
    private let agreementContentView = UIView()

    private lazy var agreementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .systemBrown
        return stackView
    }()
    
    private lazy var agreementCvStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var agreementNameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 2
        
        collectionView.register(SecurityNameCollectionViewCell.self, forCellWithReuseIdentifier: "SecurityNameCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false

        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var agreementCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 3
        
        collectionView.register(SecurityCollectionViewCell.self, forCellWithReuseIdentifier: "SecurityCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true

        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private lazy var domesticHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView:  PortFolioPieChartView(values: [1300, 500, 300, 100, 200, 400], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan, Color.white], names: ["Rent", "Transport", "Education", "1", "2", "3"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        return hostingController
    }()
    
    private lazy var overseasHostingController: UIHostingController = {
        let hostingController = UIHostingController(rootView: PortFolioPieChartView(values: [100, 500, 300], colors: [Color.blue, Color.green, Color.orange], names: ["Rent", "Transport", "Education"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        return hostingController
    }()
    
    
    
    let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    
    @objc func accountNumClicked(){
        print("accountNumClicked button clicked")
       
    }
    
    @objc func balanceButtonClicked(){
        self.isBalance = true
        
        print("balanceButtonClicked button clicked")
        self.isSector = false
        self.stockButton.layer.borderWidth = 3.0
        self.stockButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        
        self.sectorButton.layer.borderWidth = 1.0
        self.sectorButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        self.balanceButtonBottom.backgroundColor = .darkGray
        self.agreementButtonBottom.backgroundColor = .white
      
        self.glView.isHidden = false
        self.moneyHorizontalView.isHidden = false
        self.borderView.isHidden = false
        self.stockSectorStackView.isHidden = false
        self.portfolioView.isHidden = false
        self.cvStackView.isHidden = false
        self.sectorUIView.isHidden = true
        self.agreementScrollView.isHidden = true
//        self.cvStackView.snp.updateConstraints{
//            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
//        }
    }
    
    @objc func agreementButtonClicked(){
        self.isBalance = false
        print("agreementButtonClicked button clicked")
        self.balanceButtonBottom.backgroundColor = .white
        self.agreementButtonBottom.backgroundColor = .darkGray
        
        self.glView.isHidden = true
        self.moneyHorizontalView.isHidden = true
        self.borderView.isHidden = true
        self.stockSectorStackView.isHidden = true
        self.portfolioView.isHidden = true
        self.cvStackView.isHidden = true
        self.sectorUIView.isHidden = true
        self.agreementScrollView.isHidden = false
//        self.cvStackView.snp.updateConstraints{
//            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
//        }
    }
    
    @objc func stockButtonClicked(){
        print("stockButtonClicked button clicked")
        self.isSector = false
        self.stockButton.layer.borderWidth = 3.0
        self.stockButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        
        self.sectorButton.layer.borderWidth = 1.0
        self.sectorButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        
        //무조건 주식잔고가 선택되어있음!!
        
        self.portfolioView.isHidden = false
        self.cvStackView.isHidden = false
        self.sectorUIView.isHidden = true
        self.agreementScrollView.isHidden = true
    }
    
    @objc func sectorButtonClicked(){
        self.isSector = true
        //일단 초기화
        self.myDomesticSectors = [:]
        print("원래")
        print(self.myDomesticSectors)
        

        requestAPI_DomesticSector()

        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            print("나중")
            print(self.myDomesticSectors)
            
            //------------------------------- PieChart 바꾸는 부분 -------------------------------//
            
            if self.isDomestic{
                var tempArr: [( Double, String)] = []

                var now_colors: [Color] = []
//                let stride: Double = 100.0 / Double(self.myDomesticSectors.count)

//                for i in 0 ..< self.myDomesticSectors.count {
//                    now_colors.append(Color(uiColor: UIColor(red: (153 + (stride * (i + 1))) / 255.0, green: (106 + (stride * (i + 1))) / 255.0, blue: (106 + (stride * (i + 1))) / 255.0, alpha: 1.0)))
//
//                }

                for key in self.myDomesticSectors.keys{
                    tempArr.append((self.myDomesticSectors[key]!, key))
                }
                tempArr.sort{ a, b -> Bool in
                    return a.0 > b.0
                }
                let now_values: [Double] = tempArr.map{ a -> Double in
                    a.0
                }
                let now_names: [String] = tempArr.map{ a -> String in
                    a.1
                }
                self.domesticHostingController.view.snp.removeConstraints()
                self.domesticHostingController = UIHostingController(rootView:  PortFolioPieChartView(values: now_values, colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan, Color.brown, Color.mint, Color.yellow, Color.purple, Color.mint, Color.indigo], names: now_names, backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
    //            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
                
                if #available(iOS 16.0, *) {
                    self.domesticHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.domesticHostingController)
                self.domesticHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.domesticHostingController.view.snp.removeConstraints()
        
                self.sectorUIView.addSubview(self.domesticHostingController.view)
                
                self.domesticHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }else {
                
            }
            
//
            print("다끝남!! ")
            //------------------------------- PieChart 바꾸는 부분 -------------------------------//
               
            
            print("sectorButtonClicked button clicked")
            self.isSector = true
            
            self.sectorButton.layer.borderWidth = 3.0
            self.sectorButton.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 176/255.0, alpha: 1.0).cgColor
            
            self.stockButton.layer.borderWidth = 1.0
            self.stockButton.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
            
            //무조건 주식잔고가 선택되어있음!!
            self.portfolioView.isHidden = true
            self.cvStackView.isHidden = true
            self.sectorUIView.isHidden = false
            self.agreementScrollView.isHidden = true
            
            
        }
        
    
    }
    
   
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestAPI()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            self.view.backgroundColor = .systemBackground
//            self.scrollView.backgroundColor = .systemBackground
//            self.contentView.backgroundColor = .systemBackground
//            self.navigationController?.isNavigationBarHidden = true
//            //        cvScrollView.backgroundColor = .magenta
//            self.layout()
//        }
        view.backgroundColor = .white
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        
        agreementScrollView.backgroundColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        agreementContentView.backgroundColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        agreementStackView.backgroundColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        self.agreementScrollView.isHidden = true
        self.sectorUIView.isHidden = true
        layout()
        // Header쪽에서 refresh버튼 누르는 액션을 전달받기 위해
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBtnClicked), name: .refreshMyAccount, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeMarketBtnClicked), name: .changeMarket, object: nil)
        
        
//        hostingController.view.snp.removeConstraints()
        
        
//        let hostingController = UIHostingController(rootView: PortFolioPieChartView(values: [1300, 500, 300], colors: [Color.blue, Color.green, Color.orange], names: ["Rent", "Transport", "Education"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
//        if #available(iOS 16.0, *) {
//            hostingController.sizingOptions = .preferredContentSize
//        } else {
//            // Fallback on earlier versions
//        }
////        hostingController.modalPresentationStyle = .popover
////        self.present(hostingController, animated: true)
//        addChild(hostingController)
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//
//        self.sectorUIView.addSubview(hostingController.view)
//        hostingController.view.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
//        
//        view.addSubview(hostingController.view)

        
    }
    
    // --------------------------------------------  이 아래 3곳에서 view를 Update해야한다  -------------------------------------------- //
    // --------------------------------------------  이 아래 3곳에서 view를 Update해야한다  -------------------------------------------- //
    // --------------------------------------------  이 아래 3곳에서 view를 Update해야한다  -------------------------------------------- //
    
    //여기는 더 건드릴 필요가 없다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //일단 화면에 돌아올때는 항상 국내주식으로 시작하도록
        self.isDomestic = true
        requestAPI_Domestic()
        requestAPI_DomesticAgreement()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //1. 현재의 틱 (self.isDomestic)에 따라 viewController 최상단 HeaderView를 업데이트)
            self.myAccountHeader.setup(isDomestic: self.isDomestic)
            self.cvStackView.snp.updateConstraints{
                $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
            }
            self.agreementCvStackView.snp.updateConstraints{
                $0.height.equalTo(44 * (self.myDomesticAgreement.count + 1) )
            }
            
            
            self.sectorUIView.addSubview(self.domesticHostingController.view)
            
            self.domesticHostingController.view.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
        }
        
    }
    //여기도 끝
    @objc func refreshBtnClicked(){
        
        if isDomestic{
            requestAPI_Domestic()
            requestAPI_DomesticAgreement()
        }//해외면
        else {
            requestAPI_Overseas()
            requestAPI_OverseasAgreement()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //1. 현재의 틱 (self.isDomestic)에 따라 viewController 최상단 HeaderView를 업데이트)
            self.myAccountHeader.setup(isDomestic: self.isDomestic)
            //국내면
            if self.isDomestic{
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
                }
                self.agreementCvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myDomesticAgreement.count + 1) )
                }
                self.overseasHostingController.view.snp.removeConstraints()
//                self.domesticHostingController.rootView.values = [100.0, 100.0, 100.0]
//                self.sectorUIView.addSubview(self.domesticHostingController.view)
//                self.domesticHostingController.view.snp.makeConstraints{
//                    $0.edges.equalToSuperview()
//                }
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
                
                var tempArr: [( Double, String)] = []

                var now_colors: [Color] = []
//                let stride: Double = 100.0 / Double(self.myDomesticSectors.count)

//                for i in 0 ..< self.myDomesticSectors.count {
//                    now_colors.append(Color(uiColor: UIColor(red: (153 + (stride * (i + 1))) / 255.0, green: (106 + (stride * (i + 1))) / 255.0, blue: (106 + (stride * (i + 1))) / 255.0, alpha: 1.0)))
//
//                }

                for key in self.myDomesticSectors.keys{
                    tempArr.append((self.myDomesticSectors[key]!, key))
                }
                tempArr.sort{ a, b -> Bool in
                    return a.0 > b.0
                }
                let now_values: [Double] = tempArr.map{ a -> Double in
                    a.0
                }
                let now_names: [String] = tempArr.map{ a -> String in
                    a.1
                }
                
                self.domesticHostingController.view.snp.removeConstraints()
                self.domesticHostingController = UIHostingController(rootView:  PortFolioPieChartView(values: now_values, colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan, Color.brown, Color.mint, Color.yellow, Color.purple, Color.mint, Color.indigo] , names: now_names, backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
    //            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
                
                if #available(iOS 16.0, *) {
                    self.domesticHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.domesticHostingController)
                self.domesticHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.domesticHostingController.view.snp.removeConstraints()
        
                self.sectorUIView.addSubview(self.domesticHostingController.view)
                
                self.domesticHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
                
                
            }//해외면
            else {
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasSecurities.count + 1) )
                }
                self.agreementCvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasAgreement.count + 1) )
                }
                
                self.domesticHostingController.view.snp.removeConstraints()
                self.sectorUIView.addSubview(self.overseasHostingController.view)
                self.overseasHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }
        }
    }
    // 해외주식잔고 / 국내주식잔고  버튼 클릭시 변경 왔다갔다
    @objc func changeMarketBtnClicked(){
        //먼저 Domestic을 바꿔준다
        self.isDomestic = !isDomestic
        //4. 보유잔고 update 해야함
        //국내면
        if isDomestic{
            requestAPI_Domestic()
            requestAPI_DomesticAgreement()
        }//해외면
        else {
            requestAPI_Overseas()
            requestAPI_OverseasAgreement()
        }
        // API호출이 끝나고 view관련 task들은 모두 main thread에서
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //1. 현재의 틱 (self.isDomestic)에 따라 viewController 최상단 HeaderView를 업데이트)
            self.myAccountHeader.setup(isDomestic: self.isDomestic)
            
            //5. 마지막으로 collectionView 길이 늘려주기
            if self.isDomestic{
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myAccountSecurities.count + 1))
                }
                self.agreementCvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myDomesticAgreement.count + 1) )
                }
//                self.overseasHostingController.removeFromParent()
                self.overseasHostingController.view.snp.removeConstraints()
//                self.sectorUIView.addSubview(self.domesticHostingController.view)
//                self.domesticHostingController.view.snp.makeConstraints{
//                    $0.edges.equalToSuperview()
//                }
                
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
                var tempArr: [( Double, String)] = []

                var now_colors: [Color] = []
//                let stride: Double = 100.0 / Double(self.myDomesticSectors.count)

//                for i in 0 ..< self.myDomesticSectors.count {
//                    now_colors.append(Color(uiColor: UIColor(red: (153 + (stride * (i + 1))) / 255.0, green: (106 + (stride * (i + 1))) / 255.0, blue: (106 + (stride * (i + 1))) / 255.0, alpha: 1.0)))
//
//                }

                for key in self.myDomesticSectors.keys{
                    tempArr.append((self.myDomesticSectors[key]!, key))
                }
                tempArr.sort{ a, b -> Bool in
                    return a.0 > b.0
                }
                let now_values: [Double] = tempArr.map{ a -> Double in
                    a.0
                }
                let now_names: [String] = tempArr.map{ a -> String in
                    a.1
                }
                self.domesticHostingController.view.snp.removeConstraints()
                self.domesticHostingController = UIHostingController(rootView:  PortFolioPieChartView(values: now_values, colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan, Color.brown, Color.mint, Color.yellow, Color.purple, Color.mint, Color.indigo], names: now_names, backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6))
    //            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
                
                if #available(iOS 16.0, *) {
                    self.domesticHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.domesticHostingController)
                self.domesticHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.domesticHostingController.view.snp.removeConstraints()
        
                self.sectorUIView.addSubview(self.domesticHostingController.view)
                
                self.domesticHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            }//해외면
            else {
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasSecurities.count + 1))
                }
                self.agreementCvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasAgreement.count + 1) )
                }
//                self.domesticHostingController.removeFromParent()
                self.domesticHostingController.view.snp.removeConstraints()
                self.sectorUIView.addSubview(self.overseasHostingController.view)
                self.overseasHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }
        }
    }
    
    // --------------------------------------------  이 아래 3곳에서 view를 Update해야한다  -------------------------------------------- //
    

    private func layout(){
        [ myAccountHeader, accountNumButton, balanceButton, agreementButton,balanceButtonBottom, agreementButtonBottom, scrollView].forEach{
            view.addSubview($0)
        }

        myAccountHeader.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        accountNumButton.snp.makeConstraints{
            $0.top.equalTo(myAccountHeader.snp.bottom).offset(2)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        balanceButton.snp.makeConstraints{
            $0.top.equalTo(accountNumButton.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        agreementButton.snp.makeConstraints{
            $0.top.equalTo(accountNumButton.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        balanceButtonBottom.snp.makeConstraints{
            $0.top.equalTo(balanceButton.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        agreementButtonBottom.snp.makeConstraints{
            $0.top.equalTo(agreementButton.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(balanceButtonBottom.snp.bottom)
            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        
        [ stockButton, sectorButton].forEach {
            stockSectorStackView.addArrangedSubview($0)
        }
        
        stockButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        sectorButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        [ glView, moneyHorizontalView, borderView, stockSectorStackView, portfolioView, cvStackView, sectorUIView, agreementScrollView, blankView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        glView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        moneyHorizontalView.snp.makeConstraints{
            $0.top.equalTo(glView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }

        borderView.snp.makeConstraints{
            $0.top.equalTo(moneyHorizontalView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        stockSectorStackView.snp.makeConstraints{
            $0.top.equalTo(borderView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        //여기에 업종별 눌렀을 경우 넣을 차트
        
        
        
        portfolioView.snp.makeConstraints{
            $0.top.equalTo(stockSectorStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        cvStackView.snp.makeConstraints{
            $0.top.equalTo(portfolioView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            //총 12종목만 보여줌
            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1))
        }
        
        [securityNameCollectionView, securityCollectionView].forEach{
            cvStackView.addArrangedSubview($0)
        }
        
        securityNameCollectionView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width  / 3)
//            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalTo(300)
        }

        securityCollectionView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(securityNameCollectionView.snp.trailing)
//            $0.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
//            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalToSuperview()
        }
        
        
//        sectorUIView.addSubview(hostingController.view)
//        hostingController.view.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
        sectorUIView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        
        agreementScrollView.snp.makeConstraints{
            $0.top.equalTo(balanceButtonBottom.snp.bottom)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(100)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        agreementScrollView.addSubview(agreementContentView)

        agreementContentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
            $0.width.equalToSuperview()
        }
        agreementContentView.addSubview(agreementStackView)
        agreementStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        [agreementCvStackView].forEach{
            agreementStackView.addArrangedSubview($0)
        }
        
        agreementCvStackView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            //총 12종목만 보여줌
            $0.height.equalTo(44 * (self.myDomesticAgreement.count + 1))
        }
        [agreementNameCollectionView, agreementCollectionView].forEach{
            agreementCvStackView.addArrangedSubview($0)
        }
        
        agreementNameCollectionView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width  / 3)
//            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalTo(300)
        }

        agreementCollectionView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(agreementNameCollectionView.snp.trailing)
//            $0.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
//            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalToSuperview()
        }


        
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}



extension MyAccountViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return records.count
        //Header까지 포함해야하므로 1을 더해줌
        if collectionView.tag == 0 || collectionView.tag == 2{
            return 1
        }
        else if collectionView.tag == 1{
            //국내인 경우
            if self.isDomestic{
                return self.myAccountColumns.count - 1
            }else{// 해외인 경우
                return self.myOverseasColumns.count - 1
            }
        }
        else{ // tag == 3인 경우
            //국내인 경우
            if self.isDomestic{
                return self.myDomesticAgreementColumns.count - 1
            }else{// 해외인 경우
                return self.myOverseasAgreementColumns.count - 1
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 평가손익, 수익률 ..... 등을 보여줘야함
        if collectionView.tag == 0 || collectionView.tag == 1{
            if self.isDomestic{
                return self.myAccountSecurities.count + 1
            }
            else {
                return self.myOverseasSecurities.count + 1
            }
        }
        //체결내역인 경우
        else{
            if self.isDomestic{
                return self.myDomesticAgreement.count + 1
            }
            else {
                return self.myOverseasAgreement.count + 1
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //첫 열
        if collectionView.tag == 0 || collectionView.tag == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityNameCollectionViewCell", for: indexPath) as? SecurityNameCollectionViewCell else { return UICollectionViewCell() }
            // 첫 열, 첫 행
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.setup(title: "종목명")
            }
            else { //첫 열 종목명
                if collectionView.tag == 0{
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].prdt_name)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].prdt_name)
                    }
                }
                // collectionView.tag == 2
                else{
                    if self.isDomestic{
                        cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].prdt_name)
                    }else {
                        cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].prdt_name)
                    }
                }
                
            }
            return cell
        }
        // 오른쪽 collectionView  tag == 1 || 3
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityCollectionViewCell", for: indexPath) as? SecurityCollectionViewCell else { return UICollectionViewCell() }
            
            // 오른쪽 collectionView의 첫 행
            if indexPath.row == 0 {
                if collectionView.tag == 1{
                    if self.isDomestic{
                        cell.setup(title: myAccountColumns[indexPath.section + 1])
                    }else {
                        cell.setup(title: myOverseasColumns[indexPath.section + 1])
                    }
                }
                // tag == 3
                else{
                    if self.isDomestic{
                        cell.setup(title: myDomesticAgreementColumns[indexPath.section + 1])
                    }else {
                        cell.setup(title: myOverseasAgreementColumns[indexPath.section + 1])
                    }
                }
                return cell
            }
            // 오른쪽 collectionView의 두번쨰 행부터
            else {
            // 순서 : ["종목명", "종목코드", "평가손익", "수익률" ,"평가금액", "보유수량", "매입금액", "매입단가", "현재가", "등락률", "금일매수", "금일매도"]
                // 종목명 prdt_name
                // 종목코드 pdno
                //평가손익 evlu_pfls_amt
                //수익률 = 평가손익률 evlu_pfls_rt
                //평가금액 evlu_amt
                //보유수량 hldg_qty
                //매입금액 pchs_amt
                //매입단가 pchs_avg_pric
                //현재가 prpr
                //등락률 fltt_rt
                //금일매수 thdt_buyqty
                //금일매도 thdt_sll_qty
                switch indexPath.section{
                    //종목코드
                case 0:
//                    print("지금의 indexPath.row = " )
//                    print(indexPath.row)
//                    print()
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pdno)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].pdno)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].sll_buy_dvsn_cd_name)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].sll_buy_dvsn_cd_name)
                        }
                    }
                    
                    //평가손익
                case 1:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_pfls_amt)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].evlu_pfls_amt2)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].sll_buy_dvsn_cd)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].sll_buy_dvsn_cd)
                        }
                    }
                    
                    
                    // 수익률
                case 2:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_pfls_rt)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].evlu_pfls_rt1)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].ord_qty)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ft_ord_qty)
                        }
                    }
                    
                                        // 평가금액
                case 3:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_amt)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].frcr_evlu_amt2)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].avg_prvs)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ft_ccld_unpr3)
                        }
                    }
                    
                    
                    // 보유수량
                case 4:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].hldg_qty)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].cblc_qty13)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].tot_ccld_qty)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ft_ccld_qty)
                        }
                    }
                    
                    
                    //매입금액
                case 5:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pchs_amt)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].frcr_pchs_amt)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].tot_ccld_amt)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ft_ccld_amt3)
                        }
                    }
                    
                    
                    //매입단가
                case 6:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pchs_avg_pric)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].avg_unpr3)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].ord_dvsn_cd)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].odno)
                        }
                    }
                    
                    // 현재가
                case 7:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].prpr)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_now_pric1)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].odno)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ord_dt)
                        }
                    }
                    
                    
                    // 등락률
                case 8:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].fltt_rt)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].ord_dt)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ord_tmd)
                        }
                    }
                    
                    
                    //금일 매수
                case 9:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].thdt_buyqty)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].ord_tmd)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ord_tmd)
                        }
                    }
                    
                    
                    //금일 매도
                default:
                    if collectionView.tag == 1{
                        if self.isDomestic{
                            cell.setup(title: self.myAccountSecurities[indexPath.row - 1].thdt_sll_qty)
                        }else {
                            cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                        }
                    }
                    else{
                        if self.isDomestic{
                            cell.setup(title: self.myDomesticAgreement[indexPath.row - 1].ord_tmd)
                        }else {
                            cell.setup(title: self.myOverseasAgreement[indexPath.row - 1].ord_tmd)
                        }
                    }
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 || collectionView.tag == 2 {
            return CGSize(width: UIScreen.main.bounds.width  / 3, height: 44)
        }
        else {
            return CGSize(width: 120, height: 44)
        }
        
    }
       
}

extension MyAccountViewController {

    private func requestAPI_Domestic(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/inquire-balance?CANO=73085780&ACNT_PRDT_CD=01&AFHR_FLPR_YN=N&OFL_YN&INQR_DVSN=02&UNPR_DVSN=01&FUND_STTL_ICLD_YN=Y&FNCG_AMT_AUTO_RDPT_YN=N&PRCS_DVSN=00&CTX_AREA_FK100&CTX_AREA_NK100"
        
//        print("지금 만든 url = " + (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "") )
//        print("access Token = " + UserDefaults.standard.string(forKey: "accessToken")!)
//        print("appkey = " + UserDefaults.standard.string(forKey: "appkey")!)
//        print("appServiceKey = " + UserDefaults.standard.string(forKey: "appSecretKey")!)
//        print()
//        print()
        
//        request.setValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "authorization")
//        request.setValue(UserDefaults.standard.string(forKey: "appkey")!, forHTTPHeaderField: "appkey")
//        request.setValue(UserDefaults.standard.string(forKey: "appsecret")!, forHTTPHeaderField: "appsecret")
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "TTTC8434R"]
                   )
                .responseDecodable(of: MyAccountTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                                //데이터 받아옴
                    self.myAccountSecurities = data.output1.map{ obj -> MyAccountSecurities in
                        let now = MyAccountSecurities(prdt_name: obj.prdt_name, pdno: obj.pdno, evlu_pfls_amt: obj.evlu_pfls_amt, evlu_pfls_rt: obj.evlu_pfls_rt, evlu_amt: obj.evlu_amt, hldg_qty: obj.hldg_qty, pchs_amt: obj.pchs_amt, pchs_avg_pric: obj.pchs_avg_pric, prpr: obj.prpr, fltt_rt: obj.fltt_rt, thdt_buyqty: obj.thdt_buyqty, thdt_sll_qty: obj.thdt_sll_qty)
                        return now
                    }
                    print("myAccountSecurities 갱신 후")
                    print(self.myAccountSecurities)
                    print()
                    print()
                    
                    self.myAccountMoney = data.output2.map{ obj -> MyAccountMoney in
                        let now = MyAccountMoney(evlu_pfls_smtl_amt: obj.evlu_pfls_smtl_amt, dnca_tot_amt: obj.dnca_tot_amt, d2_auto_rdpt_amt: obj.d2_auto_rdpt_amt, scts_evlu_amt: obj.scts_evlu_amt, pchs_amt_smtl_amt: obj.pchs_amt_smtl_amt)
                        return now
                    }
                    print("myAccountMoney 갱신 후")
                    print(self.myAccountMoney)
                    print()
                    print()
                    
                    //먼저 평가손익 glView에서 평가손익합계금액과 총 수익률을 setup해준다
                    let temp_totalRevenueRate: String = String(Double(self.myAccountMoney[0].evlu_pfls_smtl_amt)! * 100 / Double(self.myAccountMoney[0].pchs_amt_smtl_amt)!)
                    let dot_idx = temp_totalRevenueRate.firstIndex(of: ".")
                    let two = temp_totalRevenueRate.index(after: dot_idx!)
                    let three = temp_totalRevenueRate.index(after: two)

                    print(temp_totalRevenueRate[temp_totalRevenueRate.startIndex ... three])
                    let now_totalRevenueRate = String(temp_totalRevenueRate[temp_totalRevenueRate.startIndex ... three]) + "%"
                    
                    self.glView.setup(totalRevenue: self.myAccountMoney[0].evlu_pfls_smtl_amt, totalRevenueRate: now_totalRevenueRate)
                   
                    // 평가손익 아래 촟4개 예수금 관련 창 업데이트
                    self.moneyHorizontalView.setupTitle(leftTopTitle: "평가금액", leftBottomTitle: "매입금액합계", rightTopTitle: "예수금총액", rightBottomTitle: "D+2예수금")
                    self.moneyHorizontalView.setupValue(pyunggagumTotal: self.myAccountMoney[0].scts_evlu_amt, maeipgum: self.myAccountMoney[0].pchs_amt_smtl_amt, yesugumTotal: self.myAccountMoney[0].dnca_tot_amt, D2Yesugum: self.myAccountMoney[0].d2_auto_rdpt_amt)
                    
                    //보유종목 부분 update
                    self.securityNameCollectionView.reloadData()
                    self.securityCollectionView.reloadData()
                    
        }.resume()
    }
    //해외계좌 조회는 나스닥, 뉴욕 모두 함께 됨
    private func requestAPI_Overseas(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-present-balance?CANO=73085780&ACNT_PRDT_CD=01&WCRC_FRCR_DVSN_CD=02&NATN_CD=840&TR_MKET_CD=00&INQR_DVSN_CD=00"
        
//        print("지금 만든 url = " + (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "") )
//        print("access Token = " + UserDefaults.standard.string(forKey: "accessToken")!)
//        print("appkey = " + UserDefaults.standard.string(forKey: "appkey")!)
//        print("appServiceKey = " + UserDefaults.standard.string(forKey: "appSecretKey")!)
//        print()
//        print()
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "CTRP6504R"]
                   )
                .responseDecodable(of: MyOverseasTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                                //데이터 받아옴
                    self.myOverseasSecurities = data.output1.map{ obj -> MyOverseasSecurities in
                        let now = MyOverseasSecurities(prdt_name: obj.prdt_name, pdno: obj.pdno, evlu_pfls_amt2: obj.evlu_pfls_amt2, evlu_pfls_rt1: obj.evlu_pfls_rt1, frcr_evlu_amt2: obj.frcr_evlu_amt2, cblc_qty13: obj.cblc_qty13, frcr_pchs_amt: obj.frcr_pchs_amt, avg_unpr3: obj.avg_unpr3, ovrs_now_pric1: obj.ovrs_now_pric1, ovrs_excg_cd: obj.ovrs_excg_cd)
                        return now
                    }
                    print("myOverseasSecurities 갱신 후")
                    print(self.myOverseasSecurities)
                    print()
                    print()
                    
                    self.myOverseasMoney = MyOverseasMoney(tot_evlu_pfls_amt: data.output3.tot_evlu_pfls_amt, evlu_erng_rt1: data.output3.evlu_erng_rt1, evlu_amt_smtl_amt: data.output3.evlu_amt_smtl_amt, pchs_amt_smtl_amt: data.output3.pchs_amt_smtl_amt, tot_frcr_cblc_smtl: data.output3.tot_frcr_cblc_smtl, frcr_evlu_tota: data.output3.frcr_evlu_tota)
                    
                    print("myOverseasMoney 갱신 후")
                    print(self.myOverseasMoney)
                    print()
                    print()
                    
                    //먼저 평가손익 glView에서 평가손익합계금액과 총 수익률을 setup해준다
                   
                    
                    
                    self.glView.setup(totalRevenue:  self.sliceStringAfterDot(str: self.myOverseasMoney!.tot_evlu_pfls_amt) , totalRevenueRate: self.sliceStringAfterDot(str: self.myOverseasMoney!.evlu_erng_rt1) + "%")
                   
                    // 평가손익 아래 촟4개 예수금 관련 창 업데이트
                    self.moneyHorizontalView.setupTitle(leftTopTitle: "평가금", leftBottomTitle: "달러매입금", rightTopTitle: "예수금", rightBottomTitle: "달러예수금")
                    self.moneyHorizontalView.setupValue(pyunggagumTotal: (self.myOverseasMoney?.evlu_amt_smtl_amt ?? "0") + "원", maeipgum: (self.myOverseasMoney?.pchs_amt_smtl_amt ?? "0") + "원" , yesugumTotal: self.sliceStringAfterDot(str: self.myOverseasMoney!.tot_frcr_cblc_smtl) + "원", D2Yesugum: (self.myOverseasMoney?.frcr_evlu_tota ?? "0") + "원")
                    
                    //보유종목 부분 update
                    self.securityNameCollectionView.reloadData()
                    self.securityCollectionView.reloadData()
                    
        }.resume()
    }
    
  //국내 체결내역 호출
    private func requestAPI_DomesticAgreement(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/inquire-daily-ccld?CANO=73085780&ACNT_PRDT_CD=01&INQR_STRT_DT=20230123&INQR_END_DT=20230127&SLL_BUY_DVSN_CD=00&INQR_DVSN=00&PDNO&CCLD_DVSN=00&ORD_GNO_BRNO&ODNO&INQR_DVSN_3=00&INQR_DVSN_1&CTX_AREA_FK100&CTX_AREA_NK100"
        
//        print("지금 만든 url = " + (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "") )
//        print("access Token = " + UserDefaults.standard.string(forKey: "accessToken")!)
//        print("appkey = " + UserDefaults.standard.string(forKey: "appkey")!)
//        print("appServiceKey = " + UserDefaults.standard.string(forKey: "appSecretKey")!)
//        print()
//        print()
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "TTTC8001R"]
                   )
                .responseDecodable(of: DomesticAgreementTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                                //데이터 받아옴
                    self.myDomesticAgreement = data.output1.map{ obj -> DomesticAgreementDetail in
                        let now = DomesticAgreementDetail(prdt_name: obj.prdt_name, sll_buy_dvsn_cd_name: obj.sll_buy_dvsn_cd_name, sll_buy_dvsn_cd: obj.sll_buy_dvsn_cd, ord_qty: obj.ord_qty, avg_prvs: obj.avg_prvs, tot_ccld_qty: obj.tot_ccld_qty, tot_ccld_amt: obj.tot_ccld_amt, ord_dvsn_cd: obj.ord_dvsn_cd, odno: obj.odno, ord_dt: obj.ord_dt, ord_tmd: obj.ord_tmd)
                        return now
                    }
                    print("myDomesticAgreement 갱신 후")
                    print(self.myDomesticAgreement)
                    print()
                    print()
                    
                    //보유종목 부분 update
                    self.agreementNameCollectionView.reloadData()
                    self.agreementCollectionView.reloadData()
                    
        }.resume()
    }
    
    //해외 체결내역 호출
    private func requestAPI_OverseasAgreement(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-ccnl?CANO=73085780&ACNT_PRDT_CD=01&PDNO=%&ORD_STRT_DT=20230123&ORD_END_DT=20230127&SLL_BUY_DVSN=00&CCLD_NCCS_DVSN=00&OVRS_EXCG_CD=%&SORT_SQN=AS&ORD_DT&ORD_GNO_BRNO&ODNO&CTX_AREA_NK200&CTX_AREA_FK200"
        
//        print("지금 만든 url = " + (url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "") )
//        print("access Token = " + UserDefaults.standard.string(forKey: "accessToken")!)
//        print("appkey = " + UserDefaults.standard.string(forKey: "appkey")!)
//        print("appServiceKey = " + UserDefaults.standard.string(forKey: "appSecretKey")!)
//        print()
//        print()
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" ,
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "TTTS3035R"]
                   )
                .responseDecodable(of: OverseasAgreementTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                                //데이터 받아옴
                    self.myOverseasAgreement = data.output.map{ obj -> OverseasAgreementDetail in
                        let now = OverseasAgreementDetail(prdt_name: obj.prdt_name, sll_buy_dvsn_cd_name: obj.sll_buy_dvsn_cd_name, sll_buy_dvsn_cd: obj.sll_buy_dvsn_cd, ft_ord_qty: obj.ft_ord_qty, ft_ccld_unpr3: obj.ft_ccld_unpr3, ft_ccld_qty: obj.ft_ccld_qty, ft_ccld_amt3: obj.ft_ccld_amt3, odno: obj.odno, ord_dt: obj.ord_dt, ord_tmd: obj.ord_tmd)
                        return now
                    }
                    print("myOverseasAgreement 갱신 후")
                    print(self.myOverseasAgreement)
                    print()
                    print()
                    
                    //보유종목 부분 update
                    self.agreementNameCollectionView.reloadData()
                    self.agreementCollectionView.reloadData()
                    
        }.resume()
    }
    private func sliceStringAfterDot(str: String) -> String{
        let dot_idx = str.firstIndex(of: ".")
        let two = str.index(after: dot_idx!)
        let three = str.index(after: two)

//        print(str[str.startIndex ... three])
        return String(str[str.startIndex ... three])
    }
    
    
    
    // Domestic 업종 관려 ㄴget
    //여기서
    private func requestAPI_DomesticSector(){
//        var dict: [String: Double] = [:]
        
        for i in
                myAccountSecurities{
            print(i.pdno, i.evlu_amt)
        
            let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-price?FID_COND_MRKT_DIV_CODE=J&FID_INPUT_ISCD=\(i.pdno)"
            
            AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" ,
                       method: .get,
                       headers: ["content-type": "application/json; charset=utf-8",
                                 "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                 "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                 "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                 "tr_id": "FHKST01010100"]
            )
            .responseDecodable(of: DomesticSectorTotalDto.self){ [weak self] response in
                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                guard
                    let self = self,
                    case .success(let data) = response.result else {
                    print("못함.... response는")
                    print(response)
                    return }
                //데이터 받아옴
                let now_upjong = data.output.bstp_kor_isnm
                print("지금 업종 : ")
                print(now_upjong)
                print(i.evlu_amt)
                
                if(self.myDomesticSectors[now_upjong] == nil){
                    self.myDomesticSectors[now_upjong] = Double(i.evlu_amt)!
                    print(self.myDomesticSectors)
                }
                else {
                    self.myDomesticSectors[now_upjong] = self.myDomesticSectors[now_upjong]! + Double(i.evlu_amt)!
                    print(self.myDomesticSectors)
                }
                
            }.resume()
        }

        
        
    }
    
    
    // Overseas 업종 관련 get
    // 여기서
    private func requestAPI_OverseasSector(securityCode: String){
        
       
    }
}
