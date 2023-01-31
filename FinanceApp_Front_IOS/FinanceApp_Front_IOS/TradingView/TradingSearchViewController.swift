//
//  TradingSearchViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit
import Alamofire
import SwiftUI


//이 viewController는 swiftUI를 이용한 GraphView를 띄워주기 위한 다리 역할만 함.

class TradingSearchViewController: UIViewController {
    
    // ------------------------------------------------------------------------ variables ----------------------------------------------------------------------- //
    
    
    
    private var securityArr: [String] = ["임시 종목 1", "임시 종목 2", "임시 종목 3", "임시 종목 4", "임시 종목 5", "임시 종목 6", "임시 종목 7", "임시 종목 8", "임시 종목 9", "임시 종목 10"]

    private var isHoga: Bool = true
    private var isDomestic: Bool = true
    
    //한국금융지주로 설정해놓음
    private var nowTicker: String = "071050"
    
    
    //일간 차트
    private var dayDomesticPrice: [DomesticPrice] = []
    // 주간 이평선을 위해
    private var weekDomesticPrice: [DomesticPrice] = []
    // 월간 이평선을 위해
    private var monthDomesticPrice: [DomesticPrice] = []
    
    //일간 차트 종가
    private var dayDomesticClosePrice: [Double] = []
    // 주간 이평선 종가
    private var weekDomesticClosePrice: [Double] = []
    // 월간 이평선 종가
    private var monthDomesticClosePrice: [Double] = []
    
    private var domesticNowPrice: DomesticNowPrice? = nil
    
    
    //일간 차트
    private var dayOverseasPrice: [OverseasPrice] = []
    // 주간 이평선을 위해
    private var weekOverseasPrice: [OverseasPrice] = []
    // 월간 이평선을 위해
    private var monthOverseasPrice: [OverseasPrice] = []
    
    //일간 차트 종가
    private var dayOverseasClosePrice: [Double] = []
    // 주간 이평선 종가
    private var weekOverseasClosePrice: [Double] = []
    // 월간 이평선 종가
    private var monthOverseasClosePrice: [Double] = []
    
    private var overseasNowPrice: OverseasNowPrice? = nil
    
    
    
    
    
    
    
    
    
    
    
    let dateFormatter = DateFormatter()
    
    
    // ------------------------------------------------------------------------ variables ----------------------------------------------------------------------- //
    
    
    
    // ------------------------------------------------------------------------ UI Components ----------------------------------------------------------------------- //
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "국내", style: .plain, target: self, action: #selector(leftButtonClicked))
        return button
    }()
    
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(rightRefreshButtonClicked))
        return button
    }()
    
    
    @objc func leftButtonClicked(){
        if self.isDomestic {
            self.isDomestic = false
            self.leftButton.title = "해외"
            self.formulaTextField.text = "지정가"
            self.formulaTextField.isEnabled = false
        }else{
            self.isDomestic = true
            self.leftButton.title = "국내"
            self.formulaTextField.text = ""
            self.formulaTextField.isEnabled = true
        }
        print(self.isDomestic)
    }
    
    
    @objc func rightRefreshButtonClicked(){
        print("rightButtonClicked")
        
        
        if self.isDomestic{
            
            // Header부분 업데이트
            requestAPI_DomesticPrice_now(jongmokName: self.nowTicker)
            requestAPI_DomesticPrice_former(dayWeekMonth: "D")
            requestAPI_DomesticPrice_former(dayWeekMonth: "W")
            requestAPI_DomesticPrice_former(dayWeekMonth: "M")
            // 여기서 모든 로직이 돌아가야함
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
                self.chartHostingController.view.snp.removeConstraints()
                self.chartHostingController = UIHostingController(rootView:  TradingChartView(dailyData: self.dayDomesticClosePrice, weeklyData: self.weekDomesticClosePrice, monthlyData: self.monthDomesticClosePrice, startDate: self.dateFormatter.date(from: self.dayDomesticPrice.last!.stck_bsop_date)!, endDate: self.dateFormatter.date(from: self.dayDomesticPrice.first!.stck_bsop_date )!))
    //            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
                
                if #available(iOS 16.0, *) {
                    self.chartHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.chartHostingController)
                self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
    //            self.domesticHostingController.view.snp.removeConstraints()
        
                self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
                
                self.chartHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            }
        }else{
           
            requestAPI_OverseasPrice()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.chartHostingController.view.snp.removeConstraints()
                self.chartHostingController = UIHostingController(rootView:  TradingChartView(dailyData: self.dayOverseasClosePrice, weeklyData: self.dayOverseasClosePrice, monthlyData: self.dayOverseasClosePrice, startDate: self.dateFormatter.date(from: self.dayOverseasPrice.last!.stck_bsop_date)!, endDate: self.dateFormatter.date(from: self.dayDomesticPrice.first!.stck_bsop_date )!))

                
                if #available(iOS 16.0, *) {
                    self.chartHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.chartHostingController)
                self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
                
                self.chartHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }
        }
    }
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    private let uiSc: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "종목명을 검색해주세요"
        //화면 어두워지지 않도록 false 처리
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
//    private lazy var urlTableView: UITableView = {
//        let tableView = UITableView()
////        tableView.dataSource = self
////        tableView.delegate = self
////        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
//        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
//        return tableView
//    }()
    
    private let headerView = TradingHeaderView()
    
    //주식 잔고
    private lazy var hogaButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("호가", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        btn.addTarget(self, action: #selector(hogaButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    // 체결 내역
    private lazy var chartButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("차트", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        btn.addTarget(self, action: #selector(chartButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var hogaButtonBottom: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkGray
        return btn
    }()
    
    private lazy var chartButtonBottom: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        return btn
    }()
    
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    private let tradingView = TradingView()
    
    private var tradingChartViewUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var chartHostingController: UIHostingController = {
        
        let hostingController = UIHostingController( rootView: TradingChartView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], weeklyData: [100.0, 105.2,101.0, 105.2,100.0, 105.2,100.0, 105.2,100.0, 105.2], monthlyData: [110.0, 115.2,111.0, 115.2,110.0, 125.2,120.0, 125.2,120.0, 125.2], startDate: Date(), endDate: Date() ) )
        
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
    
    
    let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    // ------------------------------------------------------------------------ UI Components ----------------------------------------------------------------------- //
    

    // ------------------------------------------------------------------------ 매수/매도 UI Components ----------------------------------------------------------------------- //
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    private var nowSecurity: SecurityForRecommend?
    
    
    // 우리가 제공할 호가방식 목록
    private let hogaList: [String] = ["시장가", "지정가"]
    // 지금 선택한 투자자를 담을 변수
    private var selectedHoga: String = ""
    
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
    
    
    private lazy var securityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목명  :"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var securityTextField: UITextField = {
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
    
    private lazy var tickerTextField: UITextField = {
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
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = .white
        
        btn.setTitle("매수", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        btn.addTarget(self, action: #selector(buyStockClicked), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var sellButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8.0
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 166/255.0, alpha: 1.0).cgColor
        btn.backgroundColor = .white
        btn.setTitle("매도", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        btn.addTarget(self, action: #selector(sellStockClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc func buyStockClicked(){
        
        //해외
        if !self.isDomestic{
            print("매수버튼 호출! - 해외")
            overSeasBuyStock()
        }else {
            print("매수버튼 호출! - 국내")
            domesticBuyStock()
        }
//
    }
    
    @objc func sellStockClicked(){
        
        if !self.isDomestic{
            print("매도버튼 호출! - 해외")
            overSeasSellStock()
        }else {
            print("매도버튼 호출! - 국내")
            domesticSellStock()
        }
    }
    
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
    
    private lazy var hogaPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.frame = CGRect(x: 2000, y: 2000, width: 200, height: 200)
        //숨겨놔야함
//        pv.isHidden = true
        pv.delegate = self
        pv.dataSource = self

        return pv
    }()
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexibleSpace,doneBtn], animated: false)
        formulaTextField.inputAccessoryView = toolBar
    }

    @objc private func dismissKeyboard(){
        self.formulaTextField.endEditing(true)
    }
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func setupTradeView(){
//        self.nowSecurity = security
//        securityTextField.text = security.securityName
//        tickerTextField.text = security.sector
    }
    
    // ------------------------------------------------------------------------ 매수/매도 UI Components ----------------------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    @objc func hogaButtonClicked(){
        self.isHoga = true
        
        self.hogaButtonBottom.backgroundColor = .darkGray
        self.chartButtonBottom.backgroundColor = .white
        
        self.tradingView.isHidden = false
        self.tradingChartViewUIView.isHidden = true
    }
    
    @objc func chartButtonClicked(){
        self.isHoga = false

        self.hogaButtonBottom.backgroundColor = .white
        self.chartButtonBottom.backgroundColor = .darkGray
        
        self.tradingView.isHidden = true
        self.tradingChartViewUIView.isHidden = false
        
        self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
        
        self.chartHostingController.view.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.formulaTextField.inputView = self.hogaPicker
        createToolBar()
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        self.scrollView.backgroundColor = .white
        self.contentView.backgroundColor = .blue
        self.stackView.backgroundColor = .cyan
        view.backgroundColor = .white
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
    
    }
    //맨 처음 들어오면 한국금융지주로 보여주도록
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false

        self.uiSc.isActive = true
        self.uiSc.isEditing = true
        
        self.tradingView.isHidden = false
        self.tradingChartViewUIView.isHidden = true
        
        self.isDomestic = true
        self.leftButton.title = "국내"
        self.nowTicker = "071050"
        
        // ---------------------- 매수매도 창 ---------------------- //
        self.formulaTextField.text = ""
        self.formulaTextField.isEnabled = true
        self.securityTextField.text = ""
        self.tickerTextField.text = ""
        self.quantityTextField.text = ""
        self.formulaTextField.text = ""
        self.designatedTextField.text = ""
       
//        self.securityTextField.isEnabled = false
//        self.tickerTextField.isEnabled = false
        // ---------------------- 매수매도 창 ---------------------- //
        
        // Header부분 업데이트
        requestAPI_DomesticPrice_now(jongmokName: "한국금융지주")
        requestAPI_DomesticPrice_former(dayWeekMonth: "D")
        requestAPI_DomesticPrice_former(dayWeekMonth: "W")
        requestAPI_DomesticPrice_former(dayWeekMonth: "M")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            self.chartHostingController.view.snp.removeConstraints()
            self.chartHostingController = UIHostingController(rootView:  TradingChartView(dailyData: self.dayDomesticClosePrice, weeklyData: self.weekDomesticClosePrice, monthlyData: self.monthDomesticClosePrice, startDate: self.dateFormatter.date(from: self.dayDomesticPrice.last!.stck_bsop_date)!, endDate: self.dateFormatter.date(from: self.dayDomesticPrice.first!.stck_bsop_date )!))
//            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
            
            if #available(iOS 16.0, *) {
                self.chartHostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }

            self.addChild(self.chartHostingController)
            self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
            
//            self.domesticHostingController.view.snp.removeConstraints()
    
            self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
            
            self.chartHostingController.view.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setNavigationItems(){
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "종목 검색"
        uiSc.obscuresBackgroundDuringPresentation = false
        uiSc.searchBar.delegate = self
        self.navigationItem.rightBarButtonItem = self.rightButton
        self.navigationItem.leftBarButtonItem = self.leftButton
        // embed UISearchController
        navigationItem.searchController = uiSc
    }
    
    
    private func layout(){
        
        [ headerView, hogaButton, chartButton, hogaButtonBottom, chartButtonBottom, scrollView].forEach{
            view.addSubview($0)
        }
        
        headerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        hogaButton.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        chartButton.snp.makeConstraints{
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        hogaButtonBottom.snp.makeConstraints{
            $0.top.equalTo(hogaButton.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        chartButtonBottom.snp.makeConstraints{
            $0.top.equalTo(chartButton.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.width / 2)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        scrollView.snp.makeConstraints{
            $0.top.equalTo(hogaButtonBottom.snp.bottom)
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
        
        
        [tradingView, tradingChartViewUIView, blankView].forEach{
            stackView.addArrangedSubview($0)
        }
        
        tradingView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1000)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        [ securityNameLabel, securityTextField, tickerNameLabel, tickerTextField, buyButton, sellButton, quantityLabel, quantityTextField, formulaLabel, formulaTextField, designatedLabel, designatedTextField].forEach{
            tradingView.addSubview($0)
        }
    

        securityNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        securityTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
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
        
        tickerTextField.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalTo(view.snp.trailing).inset( UIScreen.main.bounds.width * 3 / 4)
            $0.trailing.equalToSuperview().inset(20)
        }
        
       
        
        quantityLabel.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview().inset(20)
        }
        
        quantityTextField.snp.makeConstraints{
            $0.top.equalTo(tickerNameLabel.snp.bottom).offset(10)
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
        
        buyButton.snp.makeConstraints{
            $0.top.equalTo(designatedLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        sellButton.snp.makeConstraints{
            $0.top.equalTo(designatedLabel.snp.bottom).offset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(UIScreen.main.bounds.width / 2 - 40)
            $0.leading.equalTo(buyButton.snp.trailing).offset(40)
        }
        
        
        
        

        
        
        tradingChartViewUIView.snp.makeConstraints{
//            $0.top.equalTo(balanceButtonBottom.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
    //            $0.height.equalTo(100)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        blankView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
    //            $0.height.equalTo(100)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

}

extension TradingSearchViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //이전 검색이 있었을 경우에, DidEndEditing에서 stations리스트를 비워두었고 tableView는 그대로이기 때문에
        // reloadData() 해주지 않으면 이전 검색 내역이 그대로 tableView에 남아있다.
//        urlTableView.reloadData()
//        urlTableView.isHidden = false
//        print(urlsArr)
    }
 
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        urlTableView.isHidden = true
        //나중에 다시 검색창을 켰을 때, 이전에 검색했던 지하철역들이 TableView에 그대로 보이지 않도록 리스트 비워줌
//        urlsArr = []
        
    }
    //text가 바뀔 때마다 request를 Alamofire를 이용해 보내고 받아옴
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            return
        }
        //TODO: 여기서 UserDefaults에서 prefix가 같은 것들 검색해와서 tableVIew reload
//        let now_text = searchBar.text ?? ""
//        urlsArr[0] = now_text
        
    }
    //검색 버튼을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchButton clicked!!")
        print(searchBar.text)
        
        if self.isDomestic{
            //한국금융지주로 설정
            self.nowTicker = searchBar.text ?? "071050"
            // Header부분 업데이트
            requestAPI_DomesticPrice_now(jongmokName: self.nowTicker)
            requestAPI_DomesticPrice_former(dayWeekMonth: "D")
            requestAPI_DomesticPrice_former(dayWeekMonth: "W")
            requestAPI_DomesticPrice_former(dayWeekMonth: "M")
            // 여기서 모든 로직이 돌아가야함
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
                self.chartHostingController.view.snp.removeConstraints()
                self.chartHostingController = UIHostingController(rootView:  TradingChartView(dailyData: self.dayDomesticClosePrice, weeklyData: self.weekDomesticClosePrice, monthlyData: self.monthDomesticClosePrice, startDate: self.dateFormatter.date(from: self.dayDomesticPrice.last!.stck_bsop_date)!, endDate: self.dateFormatter.date(from: self.dayDomesticPrice.first!.stck_bsop_date )!))
    //            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
                
                if #available(iOS 16.0, *) {
                    self.chartHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.chartHostingController)
                self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
    //            self.domesticHostingController.view.snp.removeConstraints()
        
                self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
                
                self.chartHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
                // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            }
        }else{
            self.nowTicker = searchBar.text ?? "TSLA"
            requestAPI_OverseasPrice()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.chartHostingController.view.snp.removeConstraints()
                self.chartHostingController = UIHostingController(rootView:  TradingChartView(dailyData: self.dayOverseasClosePrice, weeklyData: self.dayOverseasClosePrice, monthlyData: self.dayOverseasClosePrice, startDate: self.dateFormatter.date(from: self.dayOverseasPrice.last!.stck_bsop_date)!, endDate: self.dateFormatter.date(from: self.dayDomesticPrice.first!.stck_bsop_date )!))

                
                if #available(iOS 16.0, *) {
                    self.chartHostingController.sizingOptions = .preferredContentSize
                } else {
                    // Fallback on earlier versions
                }

                self.addChild(self.chartHostingController)
                self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                
                self.tradingChartViewUIView.addSubview(self.chartHostingController.view)
                
                self.chartHostingController.view.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            }
        }
       
    }
}

extension TradingSearchViewController {
    // 국내 주식 일자별 검색
    private func requestAPI_DomesticPrice_former(dayWeekMonth: String){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-daily-price?FID_COND_MRKT_DIV_CODE=J&FID_INPUT_ISCD=\(self.nowTicker)&FID_PERIOD_DIV_CODE=\(dayWeekMonth)&FID_ORG_ADJ_PRC=0"
        
        
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
                    
                    
                    //
                    if dayWeekMonth == "D"{
                        self.dayDomesticPrice = data.output.map{ obj -> DomesticPrice in
                            let now = DomesticPrice(stck_bsop_date: obj.stck_bsop_date, stck_oprc: obj.stck_oprc, stck_hgpr: obj.stck_hgpr, stck_lwpr: obj.stck_lwpr, stck_clpr: obj.stck_clpr, acml_vol: obj.acml_vol, prdy_vrss_vol_rate: obj.prdy_vrss_vol_rate, prdy_vrss_sign: obj.prdy_vrss_sign, prdy_ctrt: obj.prdy_ctrt, frgn_ntby_qty: obj.frgn_ntby_qty)
                            return now
                        }
                        
                        self.dayDomesticClosePrice = data.output.map{ obj -> Double in
                            let now = Double(obj.stck_clpr) ?? 0.0
                            return now
                        }
                        
                        
                    } else if dayWeekMonth == "W"{
                        self.weekDomesticPrice = data.output.map{ obj -> DomesticPrice in
                            let now = DomesticPrice(stck_bsop_date: obj.stck_bsop_date, stck_oprc: obj.stck_oprc, stck_hgpr: obj.stck_hgpr, stck_lwpr: obj.stck_lwpr, stck_clpr: obj.stck_clpr, acml_vol: obj.acml_vol, prdy_vrss_vol_rate: obj.prdy_vrss_vol_rate, prdy_vrss_sign: obj.prdy_vrss_sign, prdy_ctrt: obj.prdy_ctrt, frgn_ntby_qty: obj.frgn_ntby_qty)
                            return now
                        }
                        
                        self.weekDomesticClosePrice = data.output.map{ obj -> Double in
                            let now = Double(obj.stck_clpr) ?? 0.0
                            return now
                        }
                    }
                    else{ // Month일 때
                        self.monthDomesticPrice = data.output.map{ obj -> DomesticPrice in
                            let now = DomesticPrice(stck_bsop_date: obj.stck_bsop_date, stck_oprc: obj.stck_oprc, stck_hgpr: obj.stck_hgpr, stck_lwpr: obj.stck_lwpr, stck_clpr: obj.stck_clpr, acml_vol: obj.acml_vol, prdy_vrss_vol_rate: obj.prdy_vrss_vol_rate, prdy_vrss_sign: obj.prdy_vrss_sign, prdy_ctrt: obj.prdy_ctrt, frgn_ntby_qty: obj.frgn_ntby_qty)
                            return now
                        }
                        
                        self.monthDomesticClosePrice = data.output.map{ obj -> Double in
                            let now = Double(obj.stck_clpr) ?? 0.0
                            return now
                        }
                    }
                    
                    //보유종목 부분 update
//                    self.securityNameCollectionView.reloadData()
//                    self.securityCollectionView.reloadData()
                    
        }.resume()
    }
    
    
    // 국내 주식 현재가 검색
    private func requestAPI_DomesticPrice_now(jongmokName: String){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-price?FID_COND_MRKT_DIV_CODE=J&FID_INPUT_ISCD=\(self.nowTicker)"
        
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "FHKST01010100"]
                   )
                .responseDecodable(of: DomesticNowPriceTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                    
                    
                    self.domesticNowPrice = DomesticNowPrice(rprs_mrkt_kor_name: data.output.rprs_mrkt_kor_name , bstp_kor_isnm: data.output.bstp_kor_isnm, prdy_vrss: data.output.prdy_vrss, prdy_vrss_sign: data.output.prdy_vrss_sign, prdy_ctrt: data.output.prdy_ctrt, acml_vol: data.output.acml_vol, stck_oprc: data.output.stck_oprc, stck_hgpr: data.output.stck_hgpr, stck_lwpr: data.output.stck_lwpr, stck_mxpr: data.output.stck_mxpr, stck_llam: data.output.stck_llam, frgn_ntby_qty: data.output.frgn_ntby_qty, aspr_unit: data.output.aspr_unit, w52_hgpr: data.output.w52_hgpr, w52_lwpr: data.output.w52_lwpr)
                    
                    self.headerView.setup(jongmok: jongmokName, market: data.output.rprs_mrkt_kor_name, sector: data.output.bstp_kor_isnm, prdy_vrss: data.output.prdy_vrss, prdy_vrss_sign: data.output.prdy_vrss_sign, prdy_ctrt: data.output.prdy_ctrt, acml_vol: data.output.acml_vol, stck_oprc: data.output.stck_oprc, stck_hgpr: data.output.stck_hgpr, stck_lwpr: data.output.stck_lwpr, stck_mxpr: data.output.stck_mxpr, stck_llam: data.output.stck_llam, frgn_ntby_qty: data.output.frgn_ntby_qty, isDomestic: true)
                    
                    self.securityTextField.text = self.nowTicker
                    self.tickerTextField.text = self.nowTicker
                    self.securityTextField.isEnabled = false
                    self.tickerTextField.isEnabled = false
        }.resume()
    }
}




extension TradingSearchViewController{
    // 국내주식 매수
    private func domesticBuyStock(){
        
        //여기서 먼저 비어있는 란이 없는지, 즉, 종목코드 혹은 수량 등 입력해야할 필수정보를 입력안한 것이 있는지 체크하고 알림을 띄움
        
        //종목명이 입력되지 않았을 경우
        if self.securityTextField.text == nil || self.securityTextField.text == ""{
            print("종목명를 입력해주세요 ")
            return
        }
        //종목명이 입력되지 않았을 경우
        if self.tickerTextField.text == nil || self.tickerTextField.text == ""{
            print("종목코드를 입력해주세요 ")
            return
        }
        //수량이 입력되지 않았을 경우
        if self.quantityTextField.text == nil || self.quantityTextField.text == ""{
            print("수량을 입력해주세요 ")
            return
        }
        
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "authorization")
        request.setValue(UserDefaults.standard.string(forKey: "appkey")!, forHTTPHeaderField: "appkey")
        request.setValue(UserDefaults.standard.string(forKey: "appsecret")!, forHTTPHeaderField: "appsecret")
        request.setValue("TTTC0802U", forHTTPHeaderField: "tr_id")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        // 항상 바뀌는 곳 2가지: PDNO - 종목코드, ORD_QTY - 주문수량  ... 나중에 시장가 / 지정가는 ORD_DVSN
        let now_ticker: String = self.tickerTextField.text!
        let now_quantity: String = self.quantityTextField.text!
        let params = ["CANO":"73085780", "ACNT_PRDT_CD":"01", "PDNO": now_ticker, "ORD_DVSN":"01", "ORD_QTY": now_quantity, "ORD_UNPR":"0"] as Dictionary

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
            self.dismiss(animated: true)
        }
        .resume()
    }
    // 국내주식 매도
    private func domesticSellStock(){
        //여기서 먼저 비어있는 란이 없는지, 즉, 종목코드 혹은 수량 등 입력해야할 필수정보를 입력안한 것이 있는지 체크하고 알림을 띄움
        
        //종목명이 입력되지 않았을 경우
        if self.securityTextField.text == nil || self.securityTextField.text == ""{
            print("종목명를 입력해주세요 ")
            return
        }
        //종목명이 입력되지 않았을 경우
        if self.tickerTextField.text == nil || self.tickerTextField.text == ""{
            print("종목코드를 입력해주세요 ")
            return
        }
        //수량이 입력되지 않았을 경우
        if self.quantityTextField.text == nil || self.quantityTextField.text == ""{
            print("수량을 입력해주세요 ")
            return
        }
        
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "authorization")
        request.setValue(UserDefaults.standard.string(forKey: "appkey")!, forHTTPHeaderField: "appkey")
        request.setValue(UserDefaults.standard.string(forKey: "appsecret")!, forHTTPHeaderField: "appsecret")
        request.setValue("TTTC0801U", forHTTPHeaderField: "tr_id")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        // 항상 바뀌는 곳 2가지: PDNO - 종목코드, ORD_QTY - 주문수량  ... 나중에 시장가 / 지정가는 ORD_DVSN
        let now_ticker: String = self.tickerTextField.text!
        let now_quantity: String = self.quantityTextField.text!
        let params = ["CANO":"73085780", "ACNT_PRDT_CD":"01", "PDNO": now_ticker, "ORD_DVSN":"01", "ORD_QTY": now_quantity, "ORD_UNPR":"0"] as Dictionary

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
            self.dismiss(animated: true)
        }
        .resume()
    }
    
    // 해외주식 매수
    private func overSeasBuyStock(){
        
        //종목명이 입력되지 않았을 경우
        if self.securityTextField.text == nil || self.securityTextField.text == ""{
            print("종목명를 입력해주세요 ")
            return
        }
        //종목명이 입력되지 않았을 경우
        if self.tickerTextField.text == nil || self.tickerTextField.text == ""{
            print("종목코드를 입력해주세요 ")
            return
        }
        //수량이 입력되지 않았을 경우
        if self.quantityTextField.text == nil || self.quantityTextField.text == ""{
            print("수량을 입력해주세요 ")
            return
        }
        
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/order"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "authorization")
        request.setValue(UserDefaults.standard.string(forKey: "appkey")!, forHTTPHeaderField: "appkey")
        request.setValue(UserDefaults.standard.string(forKey: "appsecret")!, forHTTPHeaderField: "appsecret")
        request.setValue("JTTT1002U", forHTTPHeaderField: "tr_id")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        //
//        let now_ticker: String = self.tickerTextField.text!
        let now_ticker: String = "MRIN"
        let now_quantity: String = self.quantityTextField.text!
        let now_market_name: String = "NYSE"
        let now_order_danga: String = "1.2"
        let params = ["CANO":"73085780", "ACNT_PRDT_CD":"01", "OVRS_EXCG_CD" : now_market_name, "PDNO": now_ticker, "ORD_QTY": now_quantity, "OVRS_ORD_UNPR": now_order_danga, "ORD_SVR_DVSN_CD": "0", "ORD_DVSN": "00"] as Dictionary

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
            self.dismiss(animated: true)
        }
        .resume()
    }
    
    // 해외주식 매도
    private func overSeasSellStock(){
        
        //종목명이 입력되지 않았을 경우
        if self.securityTextField.text == nil || self.securityTextField.text == ""{
            print("종목명를 입력해주세요 ")
            return
        }
        //종목명이 입력되지 않았을 경우
        if self.tickerTextField.text == nil || self.tickerTextField.text == ""{
            print("종목코드를 입력해주세요 ")
            return
        }
        //수량이 입력되지 않았을 경우
        if self.quantityTextField.text == nil || self.quantityTextField.text == ""{
            print("수량을 입력해주세요 ")
            return
        }
        
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "authorization")
        request.setValue(UserDefaults.standard.string(forKey: "appkey")!, forHTTPHeaderField: "appkey")
        request.setValue(UserDefaults.standard.string(forKey: "appsecret")!, forHTTPHeaderField: "appsecret")
        request.setValue("JTTT1006U", forHTTPHeaderField: "tr_id")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        //
//        let now_ticker: String = self.tickerTextField.text!
        let now_ticker: String = "MRIN"
        let now_quantity: String = self.quantityTextField.text!
        let now_market_name: String = "NASD"
        let now_order_danga: String = ""
        let params = ["CANO":"73085780", "ACNT_PRDT_CD":"01", "OVRS_EXCG_CD" : now_market_name, "PDNO": now_ticker, "ORD_QTY": now_quantity, "OVRS_ORD_UNPR": now_order_danga, "ORD_SVR_DVSN_CD": "0", "ORD_DVSN": "00"] as Dictionary

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
            self.dismiss(animated: true)
        }
        .resume()
    }
}


extension TradingSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hogaList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hogaList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select\(hogaList[row])")
        self.selectedHoga = hogaList[row]
        formulaTextField.text = hogaList[row]
    }
}


extension TradingSearchViewController{
    
    private func requestAPI_OverseasPrice(){
        
        let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-price/v1/quotations/inquire-daily-chartprice?FID_COND_MRKT_DIV_CODE=N&FID_INPUT_ISCD=\(self.nowTicker)&FID_INPUT_DATE_1=20221201&FID_INPUT_DATE_2=20230131&FID_PERIOD_DIV_CODE=D"
        
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed.union( CharacterSet(["%"]))) ?? "",
                   method: .get,
                   headers: ["content-type": "application/json; charset=utf-8",
                                             "authorization": UserDefaults.standard.string(forKey: "accessToken")!,
                                             "appkey": UserDefaults.standard.string(forKey: "appkey")!,
                                             "appsecret": UserDefaults.standard.string(forKey: "appsecret")!,
                                             "tr_id": "FHKST03030100"]
                   )
                .responseDecodable(of: OverseasPriceTotalDto.self){ [weak self] response in
                                // success 이외의 응답을 받으면, else문에 걸려 함수 종료
                                guard
                                    let self = self,
                                    case .success(let data) = response.result else {
                                    print("못함.... response는")
                                    print(response)
                                    return }
                    
                                //데이터 받아옴
                    
                    self.overseasNowPrice = OverseasNowPrice(ovrs_nmix_prdy_vrss: data.output1.ovrs_nmix_prdy_vrss, prdy_vrss_sign: data.output1.prdy_vrss_sign, prdy_ctrt: data.output1.prdy_ctrt, ovrs_nmix_prdy_clpr: data.output1.ovrs_nmix_prdy_clpr, acml_vol: data.output1.acml_vol, hts_kor_isnm: data.output1.hts_kor_isnm, ovrs_nmix_prpr: data.output1.ovrs_nmix_prpr, stck_shrn_iscd: data.output1.stck_shrn_iscd, ovrs_prod_oprc: data.output1.ovrs_prod_oprc, ovrs_prod_hgpr: data.output1.ovrs_prod_hgpr, ovrs_prod_lwpr: data.output1.ovrs_prod_lwpr)
                    
                    self.dayOverseasPrice = data.output2.map{ obj -> OverseasPrice in
                        let now = OverseasPrice(stck_bsop_date: obj.stck_bsop_date, ovrs_nmix_prpr: obj.ovrs_nmix_prpr, ovrs_nmix_oprc: obj.ovrs_nmix_oprc, ovrs_nmix_hgpr: obj.ovrs_nmix_hgpr, ovrs_nmix_lwpr: obj.ovrs_nmix_lwpr, acml_vol: obj.acml_vol, mod_yn: obj.mod_yn)
                        return now
                    }
                    self.dayOverseasClosePrice = data.output2.map{ obj -> Double in
                        let now = Double(obj.ovrs_nmix_prpr) ?? 0.0
                        return now
                    }
                    
                    self.headerView.setup(jongmok: data.output1.hts_kor_isnm, market: data.output1.stck_shrn_iscd, sector: "", prdy_vrss: data.output1.ovrs_nmix_prdy_vrss, prdy_vrss_sign: data.output1.prdy_vrss_sign, prdy_ctrt: data.output1.prdy_ctrt, acml_vol: data.output1.acml_vol, stck_oprc: data.output1.ovrs_prod_oprc, stck_hgpr: data.output1.ovrs_prod_hgpr, stck_lwpr: data.output1.ovrs_prod_lwpr, stck_mxpr: "X", stck_llam: "X", frgn_ntby_qty: "", isDomestic: false)
                    
                    //보유종목 부분 update
                    self.securityTextField.text = self.nowTicker
                    self.tickerTextField.text = self.nowTicker
                    self.securityTextField.isEnabled = false
                    self.tickerTextField.isEnabled = false
                    
        }.resume()
    }
    
}
