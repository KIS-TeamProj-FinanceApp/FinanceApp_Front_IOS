//
//  MyAccountViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit


class MyAccountViewController: UIViewController {
    
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
    private var securities: [MyAccountSecurities] = [
        MyAccountSecurities(prdt_name: "임시 종목명1", pdno: "000001", evlu_pfls_amt: "평가손익1", evlu_pfls_rt: "수익률1", evlu_amt: "평가금액1", hldg_qty: "보유수량1", pchs_amt: "매입금액1", pchs_avg_pric: "매입단가1", prpr: "현재가1", fltt_rt: "등락률1", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명2", pdno: "000002", evlu_pfls_amt: "평가손익2", evlu_pfls_rt: "수익률2", evlu_amt: "평가금액2", hldg_qty: "보유수량2", pchs_amt: "매입금액2", pchs_avg_pric: "매입단가2", prpr: "현재가2", fltt_rt: "등락률2", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명3", pdno: "000003", evlu_pfls_amt: "평가손익3", evlu_pfls_rt: "수익률3", evlu_amt: "평가금액3", hldg_qty: "보유수량3", pchs_amt: "매입금액3", pchs_avg_pric: "매입단가3", prpr: "현재가3", fltt_rt: "등락률3", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명4", pdno: "000004", evlu_pfls_amt: "평가손익4", evlu_pfls_rt: "수익률4", evlu_amt: "평가금액4", hldg_qty: "보유수량4", pchs_amt: "매입금액4", pchs_avg_pric: "매입단가4", prpr: "현재가4", fltt_rt: "등락률4", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명5", pdno: "000005", evlu_pfls_amt: "평가손익5", evlu_pfls_rt: "수익률5", evlu_amt: "평가금액5", hldg_qty: "보유수량5", pchs_amt: "매입금액5", pchs_avg_pric: "매입단가5", prpr: "현재가5", fltt_rt: "등락률5", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명6", pdno: "000006", evlu_pfls_amt: "평가손익6", evlu_pfls_rt: "수익률6", evlu_amt: "평가금액6", hldg_qty: "보유수량6", pchs_amt: "매입금액6", pchs_avg_pric: "매입단가6", prpr: "현재가6", fltt_rt: "등락률6", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명7", pdno: "000007", evlu_pfls_amt: "평가손익7", evlu_pfls_rt: "수익률7", evlu_amt: "평가금액7", hldg_qty: "보유수량7", pchs_amt: "매입금액7", pchs_avg_pric: "매입단가7", prpr: "현재가7", fltt_rt: "등락률7", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명8", pdno: "000008", evlu_pfls_amt: "평가손익8", evlu_pfls_rt: "수익률8", evlu_amt: "평가금액8", hldg_qty: "보유수량8", pchs_amt: "매입금액8", pchs_avg_pric: "매입단가8", prpr: "현재가8", fltt_rt: "등락률8", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명9", pdno: "000009", evlu_pfls_amt: "평가손익9", evlu_pfls_rt: "수익률9", evlu_amt: "평가금액9", hldg_qty: "보유수량9", pchs_amt: "매입금액9", pchs_avg_pric: "매입단가9", prpr: "현재가9", fltt_rt: "등락률9", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1"),
        MyAccountSecurities(prdt_name: "임시 종목명10", pdno: "0000010", evlu_pfls_amt: "평가손익10", evlu_pfls_rt: "수익률10", evlu_amt: "평가금액10", hldg_qty: "보유수량10", pchs_amt: "매입금액10", pchs_avg_pric: "매입단가10", prpr: "현재가10", fltt_rt: "등락률10", thdt_buyqty: "금일매수1", thdt_sll_qty: "금일매도1")
        ]
    
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
        btn.layer.borderColor = UIColor.magenta.cgColor
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
        btn.layer.borderColor = UIColor.magenta.cgColor
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
        stackView.backgroundColor = .yellow
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
        stackView.backgroundColor = .red
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

        collectionView.backgroundColor = .lightGray
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

        collectionView.backgroundColor = .lightGray
//        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    
    
    
    let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .yellow
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
    }
    
    @objc func agreementButtonClicked(){
        print("agreementButtonClicked button clicked")
        self.balanceButtonBottom.backgroundColor = .white
        self.agreementButtonBottom.backgroundColor = .darkGray
        
        self.securities.append(MyAccountSecurities(prdt_name: "임시 종목명11", pdno: "0000011", evlu_pfls_amt: "평가손익11", evlu_pfls_rt: "수익률11", evlu_amt: "평가금액11", hldg_qty: "보유수량11", pchs_amt: "매입금액11", pchs_avg_pric: "매입단가11", prpr: "현재가11", fltt_rt: "등락률11", thdt_buyqty: "금일매수11", thdt_sll_qty: "금일매도11"))
        self.securities.append(MyAccountSecurities(prdt_name: "임시 종목명12", pdno: "0000012", evlu_pfls_amt: "평가손익12", evlu_pfls_rt: "수익률12", evlu_amt: "평가금액12", hldg_qty: "보유수량12", pchs_amt: "매입금액12", pchs_avg_pric: "매입단가12", prpr: "현재가12", fltt_rt: "등락률12", thdt_buyqty: "금일매수12", thdt_sll_qty: "금일매도12"))
        
        self.securityNameCollectionView.reloadData()
        self.securityCollectionView.reloadData()
        self.cvStackView.snp.updateConstraints{
            $0.height.equalTo(44 * (self.securities.count + 1) )
        }
        //            headerView.snp.updateConstraints { make in
        //                  make.height.equalTo(height)
        //              }
        
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
        view.backgroundColor = .systemBackground
        scrollView.backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = true
//        cvScrollView.backgroundColor = .magenta
        attribute()
        layout()
    }
    
    
    
    private func attribute(){

    }
    

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
        
        
        
        
        [ glView, moneyHorizontalView, borderView, stockSectorStackView, portfolioView, cvStackView, blankView].forEach{
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
            $0.height.equalTo(44 * (self.securities.count + 1))
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

//
//        cvScrollView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(500)
//        }
//
//
//        cvScrollView.addSubview(cvContentView)
//
//        cvContentView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
//            $0.width.equalToSuperview()
//        }
//        cvContentView.addSubview(cvStackView)
//        cvStackView.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
//
//        [securityNameCollectionView, securityCollectionView].forEach{
//            cvStackView.addArrangedSubview($0)
//        }
//
//        securityNameCollectionView.snp.makeConstraints{
////            $0.top.equalTo(portfolioView.snp.bottom)
//            $0.top.bottom.equalToSuperview()
////            $0.leading.equalToSuperview()
//            $0.width.equalTo(UIScreen.main.bounds.width  / 3)
////            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalTo(100)
//        }
//
//        securityCollectionView.snp.makeConstraints{
////            $0.top.equalTo(portfolioView.snp.bottom)
//            $0.top.bottom.equalToSuperview()
////            $0.leading.equalTo(securityNameCollectionView.snp.trailing)
////            $0.trailing.equalToSuperview()
//            $0.width.equalTo(UIScreen.main.bounds.width * 2 / 3)
////            $0.height.equalTo(44 * (self.securities.count + 1))
//            $0.height.equalTo(100)
//        }
        
        
//        cvStackView.snp.makeConstraints{
//            $0.top.equalTo(portfolioView.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.equalTo(44 * (self.securities.count + 1))
//        }
        
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
        return self.myAccountColumns.count - 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 평가손익, 수익률 ..... 등을 보여줘야함
        return self.securities.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //첫 열
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityNameCollectionViewCell", for: indexPath) as? SecurityNameCollectionViewCell else { return UICollectionViewCell() }
            // 첫 열, 첫 행
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.setup(title: "종목명")
            }
            else {
                cell.setup(title: securities[indexPath.row - 1].prdt_name)
            }
            return cell
        }
        // 오른쪽 collectionView
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityCollectionViewCell", for: indexPath) as? SecurityCollectionViewCell else { return UICollectionViewCell() }
            
            // 오른쪽 collectionView의 첫 행
            if indexPath.row == 0 {
                cell.setup(title: myAccountColumns[indexPath.section + 1])
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
            case 0:
                cell.setup(title: securities[indexPath.row - 1].pdno)
            case 1:
                cell.setup(title: securities[indexPath.row - 1].evlu_pfls_amt)
            case 2:
                cell.setup(title: securities[indexPath.row - 1].evlu_pfls_rt)
            case 3:
                cell.setup(title: securities[indexPath.row - 1].evlu_amt)
            case 4:
                cell.setup(title: securities[indexPath.row - 1].hldg_qty)
            case 5:
                cell.setup(title: securities[indexPath.row - 1].pchs_amt)
            case 6:
                cell.setup(title: securities[indexPath.row - 1].pchs_avg_pric)
            case 7:
                cell.setup(title: securities[indexPath.row - 1].prpr)
            case 8:
                cell.setup(title: securities[indexPath.row - 1].fltt_rt)
            case 9:
                cell.setup(title: securities[indexPath.row - 1].thdt_buyqty)
            default:
                cell.setup(title: securities[indexPath.row - 1].thdt_sll_qty)
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

