//
//  MyAccountViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit


class MyAccountViewController: UIViewController {
    
    
    private var securities: [SecurityForRecommend] = [
        SecurityForRecommend(securityName: "셀바스AI", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI2", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI3", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI4", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI5", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI6", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI7", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI8", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI9", sector: "AI/IT"),
        SecurityForRecommend(securityName: "셀바스AI10", sector: "AI/IT"),
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
    
    
    
    private lazy var glStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        stackView.backgroundColor = UIColor.lightGray
        return stackView
    }()
    
    private let glLeftHalf = glHalfView()
    
    private let glRightHalf = glHalfView()
    
    let borderView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
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
    
    private lazy var stack2View: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0.0
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    private let portfolioView = PortfolioView()
    
    //collectionView 2개를 써야한다.
    
    
    
    private let cvScrollView = UIScrollView()
    private let cvContentView = UIView()
    
    private lazy var cvStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
        cvScrollView.backgroundColor = .magenta
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
            stack2View.addArrangedSubview($0)
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
        
        
        [glLeftHalf, glRightHalf].forEach{
            glStackView.addArrangedSubview($0)
        }
        glLeftHalf.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(20)
//            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 30)
//            $0.width.equalTo(150)
//            $0.leading.equalToSuperview().inset(10)
        }
        
        glRightHalf.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(20)
//            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 30)
//            $0.width.equalTo(150)
//            $0.trailing.equalToSuperview().inset(20)
        }
        
        
        
        [ glView, glStackView, borderView, stack2View, portfolioView, cvScrollView, blankView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        glView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        glStackView.snp.makeConstraints{
            $0.top.equalTo(glView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        borderView.snp.makeConstraints{
            $0.top.equalTo(glStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        stack2View.snp.makeConstraints{
            $0.top.equalTo(borderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        portfolioView.snp.makeConstraints{
            $0.top.equalTo(stack2View.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        cvScrollView.snp.makeConstraints{
            $0.top.equalTo(portfolioView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        cvScrollView.addSubview(cvContentView)
        cvContentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            //가로를 고정시켜주어 세로스크롤 뷰가 된다.
            $0.width.equalToSuperview()
        }
        cvContentView.addSubview(cvStackView)
        
        cvStackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
//        [getDataButton, tableView].forEach{
//            stackView.addArrangedSubview($0)
//        }
        
        
        
        
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
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 평가손익, 수익률 ..... 등을 보여줘야함
        return self.securities.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityNameCollectionViewCell", for: indexPath) as? SecurityNameCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(title: String(indexPath.section) + String(indexPath.row))
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecurityCollectionViewCell", for: indexPath) as? SecurityCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(title: String(indexPath.section) + String(indexPath.row))
            return cell
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

