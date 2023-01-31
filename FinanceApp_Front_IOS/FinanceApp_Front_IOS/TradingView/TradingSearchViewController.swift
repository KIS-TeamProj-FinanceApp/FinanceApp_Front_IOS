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
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
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
    
    let dateFormatter = DateFormatter()
    
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    private lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "국내", style: .plain, target: self, action: #selector(leftButtonClicked))
        return button
    }()
    
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(rightButtonClicked))
        return button
    }()
    
    
    @objc func leftButtonClicked(){
        if self.isDomestic {
            self.isDomestic = false
            self.leftButton.title = "해외"
        }else{
            self.isDomestic = true
            self.leftButton.title = "국내"
        }
        print(self.isDomestic)
    }
    
    
    @objc func rightButtonClicked(){
        print("rightButtonClicked")
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
    
    
//    TradingChartView(chartData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2])
    
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
        self.rightButton.title = "국내"
        self.nowTicker = "071050"
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
            $0.height.equalTo(600)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        
        
    }
}



// 키보드 내리기 위한 코드
extension TradingSearchViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
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
                    
                    self.headerView.setup(jongmok: jongmokName, market: data.output.rprs_mrkt_kor_name, sector: data.output.bstp_kor_isnm, prdy_vrss: data.output.prdy_vrss, prdy_vrss_sign: data.output.prdy_vrss_sign, prdy_ctrt: data.output.prdy_ctrt, acml_vol: data.output.acml_vol, stck_oprc: data.output.stck_oprc, stck_hgpr: data.output.stck_hgpr, stck_lwpr: data.output.stck_lwpr, stck_mxpr: data.output.stck_mxpr, stck_llam: data.output.stck_llam, frgn_ntby_qty: data.output.frgn_ntby_qty)
                    //보유종목 부분 update
//                    self.securityNameCollectionView.reloadData()
//                    self.securityCollectionView.reloadData()
        }.resume()
    }
}
