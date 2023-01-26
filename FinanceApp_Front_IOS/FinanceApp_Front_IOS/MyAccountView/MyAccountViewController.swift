//
//  MyAccountViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit
import Alamofire

class MyAccountViewController: UIViewController {
    
    
    private var appKey: String = "PSbri9T298VyxfJ004x9MnCQnx7gKJR8v658"
    private var appSecretKey: String = "VUn2CzaKPT1oTzwfBiXlY2ASg8SEndHMk/h5ukdZOElQVP5dfnfnv3OiTqw3aKYGR1NRYg17q05zOFlFhW8CdwYzMPI2wmqB9cNgx2f03O1ROveEw6Kr/CeGojxZBPMVU2MMzun4Gapcq1zu+lWYhbkDK/fAfmeCD+ftD2WMWPrJw9UBG0c="
    private var accessToken: String = "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6ImZjZTk0OTJhLWViODEtNDk2OS1iYzc1LTc2MDI1MTM5YTc2NyIsImlzcyI6InVub2d3IiwiZXhwIjoxNjc0Nzk4NDMyLCJpYXQiOjE2NzQ3MTIwMzIsImp0aSI6IlBTYnJpOVQyOThWeXhmSjAwNHg5TW5DUW54N2dLSlI4djY1OCJ9.-7-80CZXIOPo36d3SWET4qCvJT2dAgSj0nDcYJ99QkT64-tlssj3rVCcTglHDcbYE_-CFcvCG5tjmvDySfArQA"
    
    
    private var myAccountSecurities: [MyAccountSecurities] = [MyAccountSecurities(prdt_name: "", pdno: "", evlu_pfls_amt: "", evlu_pfls_rt: "", evlu_amt: "", hldg_qty: "", pchs_amt: "", pchs_avg_pric: "", prpr: "", fltt_rt: "", thdt_buyqty: "", thdt_sll_qty: "")]
    //배열에 하나밖에 안 나옴 어차피
    private var myAccountMoney: [MyAccountMoney] = [MyAccountMoney(evlu_pfls_smtl_amt: "", dnca_tot_amt: "", d2_auto_rdpt_amt: "", scts_evlu_amt: "", pchs_amt_smtl_amt: "")]
    private var domesticTotalSuikRyul: String = "0.00%"
    
    //해외용
    private var myOverseasSecurities: [MyOverseasSecurities] = []
    //배열에 하나밖에 안 나옴 어차피
    private var myOverseasMoney: MyOverseasMoney? = nil
    
    
    private var isDomestic: Bool = true
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
    
    private let myAccountColumns: [String] = ["종목명", "종목코드", "평가손익", "수익률" ,"평가금액", "보유수량", "매입금액", "매입단가", "현재가", "등락률", "금일매수", "금일매도"]
    private let myOverseasColumns: [String] = ["종목명", "종목코드", "평가손익", "수익률" ,"평가금액", "보유수량", "매입금액", "매입단가", "현재가", "거래통화"]
//    private var securities: [MyAccountSecurities] = [
//        MyAccountSecurities(prdt_name: "임시 종목명1", pdno: "000001", evlu_pfls_amt: "평가손익1", evlu_pfls_rt: "수익률1", evlu_amt: "평가금액1", hldg_qty: "보유수량1", pchs_amt: "매입금액1", pchs_avg_pric: "매입단가1", prpr: "현재가1", fltt_rt: "등락률1", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명2", pdno: "000002", evlu_pfls_amt: "평가손익2", evlu_pfls_rt: "수익률2", evlu_amt: "평가금액2", hldg_qty: "보유수량2", pchs_amt: "매입금액2", pchs_avg_pric: "매입단가2", prpr: "현재가2", fltt_rt: "등락률2", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명3", pdno: "000003", evlu_pfls_amt: "평가손익3", evlu_pfls_rt: "수익률3", evlu_amt: "평가금액3", hldg_qty: "보유수량3", pchs_amt: "매입금액3", pchs_avg_pric: "매입단가3", prpr: "현재가3", fltt_rt: "등락률3", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명4", pdno: "000004", evlu_pfls_amt: "평가손익4", evlu_pfls_rt: "수익률4", evlu_amt: "평가금액4", hldg_qty: "보유수량4", pchs_amt: "매입금액4", pchs_avg_pric: "매입단가4", prpr: "현재가4", fltt_rt: "등락률4", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명5", pdno: "000005", evlu_pfls_amt: "평가손익5", evlu_pfls_rt: "수익률5", evlu_amt: "평가금액5", hldg_qty: "보유수량5", pchs_amt: "매입금액5", pchs_avg_pric: "매입단가5", prpr: "현재가5", fltt_rt: "등락률5", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명6", pdno: "000006", evlu_pfls_amt: "평가손익6", evlu_pfls_rt: "수익률6", evlu_amt: "평가금액6", hldg_qty: "보유수량6", pchs_amt: "매입금액6", pchs_avg_pric: "매입단가6", prpr: "현재가6", fltt_rt: "등락률6", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명7", pdno: "000007", evlu_pfls_amt: "평가손익7", evlu_pfls_rt: "수익률7", evlu_amt: "평가금액7", hldg_qty: "보유수량7", pchs_amt: "매입금액7", pchs_avg_pric: "매입단가7", prpr: "현재가7", fltt_rt: "등락률7", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명8", pdno: "000008", evlu_pfls_amt: "평가손익8", evlu_pfls_rt: "수익률8", evlu_amt: "평가금액8", hldg_qty: "보유수량8", pchs_amt: "매입금액8", pchs_avg_pric: "매입단가8", prpr: "현재가8", fltt_rt: "등락률8", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명9", pdno: "000009", evlu_pfls_amt: "평가손익9", evlu_pfls_rt: "수익률9", evlu_amt: "평가금액9", hldg_qty: "보유수량9", pchs_amt: "매입금액9", pchs_avg_pric: "매입단가9", prpr: "현재가9", fltt_rt: "등락률9", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
//        MyAccountSecurities(prdt_name: "임시 종목명10", pdno: "0000010", evlu_pfls_amt: "평가손익10", evlu_pfls_rt: "수익률10", evlu_amt: "평가금액10", hldg_qty: "보유수량10", pchs_amt: "매입금액10", pchs_avg_pric: "매입단가10", prpr: "현재가10", fltt_rt: "등락률10", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1")
//        ]
    
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
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0).cgColor
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
    
    //collectionView 2개를 써야한다.
    
    
//
//    private let cvScrollView = UIScrollView()
//    private let cvContentView = UIView()
//
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
        print("balanceButtonClicked button clicked")
        self.balanceButtonBottom.backgroundColor = .darkGray
        self.agreementButtonBottom.backgroundColor = .white
      
        self.glView.isHidden = false
        self.moneyHorizontalView.isHidden = false
        self.borderView.isHidden = false
        self.stockSectorStackView.isHidden = false
        self.portfolioView.isHidden = false
        self.cvStackView.isHidden = false
        self.agreementScrollView.isHidden = true
//        self.cvStackView.snp.updateConstraints{
//            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
//        }
    }
    
    @objc func agreementButtonClicked(){
        print("agreementButtonClicked button clicked")
        self.balanceButtonBottom.backgroundColor = .white
        self.agreementButtonBottom.backgroundColor = .darkGray
        
        self.glView.isHidden = true
        self.moneyHorizontalView.isHidden = true
        self.borderView.isHidden = true
        self.stockSectorStackView.isHidden = true
        self.portfolioView.isHidden = true
        self.cvStackView.isHidden = true
        self.agreementScrollView.isHidden = false
//        self.cvStackView.snp.updateConstraints{
//            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
//        }
    }
    
    @objc func stockButtonClicked(){
        print("stockButtonClicked button clicked")
    }
    
    @objc func sectorButtonClicked(){
        print("sectorButtonClicked button clicked")
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
        
        agreementScrollView.backgroundColor = .systemPink
        agreementContentView.backgroundColor = .systemPink
        agreementStackView.backgroundColor = .systemPink
        self.agreementScrollView.isHidden = true
        layout()
        // Header쪽에서 refresh버튼 누르는 액션을 전달받기 위해
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBtnClicked), name: .refreshMyAccount, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeMarketBtnClicked), name: .changeMarket, object: nil)
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //1. 현재의 틱 (self.isDomestic)에 따라 viewController 최상단 HeaderView를 업데이트)
            self.myAccountHeader.setup(isDomestic: self.isDomestic)
            self.cvStackView.snp.updateConstraints{
                $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
            }
        }
    }
    //여기도 끝
    @objc func refreshBtnClicked(){
        
        if isDomestic{
            requestAPI_Domestic()
        }//해외면
        else {
            requestAPI_Overseas()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //1. 현재의 틱 (self.isDomestic)에 따라 viewController 최상단 HeaderView를 업데이트)
            self.myAccountHeader.setup(isDomestic: self.isDomestic)
            //국내면
            if self.isDomestic{
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myAccountSecurities.count + 1) )
                }
            }//해외면
            else {
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasSecurities.count + 1) )
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
        }//해외면
        else {
            requestAPI_Overseas()
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
            }//해외면
            else {
                self.cvStackView.snp.updateConstraints{
                    $0.height.equalTo(44 * (self.myOverseasSecurities.count + 1))
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
        
        [ glView, moneyHorizontalView, borderView, stockSectorStackView, portfolioView, cvStackView, agreementScrollView, blankView].forEach{
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
        
        portfolioView.snp.makeConstraints{
            $0.top.equalTo(stockSectorStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
//        cvScrollView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(500)
//        }
//        cvScrollView.addSubview(cvContentView)
//        cvContentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
//            $0.width.equalToSuperview()
//        }
//        cvContentView.addSubview(cvStackView)
//
        cvStackView.snp.makeConstraints{
            $0.top.equalTo(portfolioView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            //총 12종목만 보여줌
            $0.height.equalTo(44 * (self.myAccountSecurities.count + 1))
        }
//
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
        if collectionView.tag == 0{
            return 1
        }
        //국내인 경우
        if self.isDomestic{
            return self.myAccountColumns.count - 1
        }else{// 해외인 경우
            return self.myOverseasColumns.count - 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 평가손익, 수익률 ..... 등을 보여줘야함
        if self.isDomestic{
            return self.myAccountSecurities.count + 1
        }
        else {
            return self.myOverseasSecurities.count + 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //첫 열
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityNameCollectionViewCell", for: indexPath) as? SecurityNameCollectionViewCell else { return UICollectionViewCell() }
            // 첫 열, 첫 행
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.setup(title: "종목명")
            }
            else { //첫 열 종목명
                if self.isDomestic{
                    cell.setup(title: self.myAccountSecurities[indexPath.row - 1].prdt_name)
                }else {
                    cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].prdt_name)
                }
            }
            return cell
        }
        // 오른쪽 collectionView
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityCollectionViewCell", for: indexPath) as? SecurityCollectionViewCell else { return UICollectionViewCell() }
            
            // 오른쪽 collectionView의 첫 행
            if indexPath.row == 0 {
                if self.isDomestic{
                    cell.setup(title: myAccountColumns[indexPath.section + 1])
                }else {
                    cell.setup(title: myOverseasColumns[indexPath.section + 1])
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
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pdno)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].pdno)
                    }
                    //평가손익
                case 1:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_pfls_amt)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].evlu_pfls_amt2)
                    }
                    
                    // 수익률
                case 2:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_pfls_rt)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].evlu_pfls_rt1)
                    }
                                        // 평가금액
                case 3:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].evlu_amt)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].frcr_evlu_amt2)
                    }
                    
                    // 보유수량
                case 4:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].hldg_qty)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].cblc_qty13)
                    }
                    
                    //매입금액
                case 5:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pchs_amt)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].frcr_pchs_amt)
                    }
                    
                    //매입단가
                case 6:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].pchs_avg_pric)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].avg_unpr3)
                    }
                    // 현재가
                case 7:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].prpr)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_now_pric1)
                    }
                    
                    // 등락률
                case 8:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].fltt_rt)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                    }
                    
                    //금일 매수
                case 9:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].thdt_buyqty)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                    }
                    
                    //금일 매도
                default:
                    if self.isDomestic{
                        cell.setup(title: self.myAccountSecurities[indexPath.row - 1].thdt_sll_qty)
                    }else {
                        cell.setup(title: self.myOverseasSecurities[indexPath.row - 1].ovrs_excg_cd)
                    }
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
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
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": accessToken,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appSecretKey")!,
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
                                             "authorization": accessToken,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appSecretKey")!,
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
    
    private func sliceStringAfterDot(str: String) -> String{
        let dot_idx = str.firstIndex(of: ".")
        let two = str.index(after: dot_idx!)
        let three = str.index(after: two)

//        print(str[str.startIndex ... three])
        return String(str[str.startIndex ... three])
    }
}
