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
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "국내", style: .plain, target: self, action: #selector(rightButtonClicked))
        return button
    }()
    
    @objc func rightButtonClicked(){
        if self.isDomestic {
            self.isDomestic = false
            self.rightButton.title = "해외"
        }else{
            self.isDomestic = true
            self.rightButton.title = "국내"
        }
        print(self.isDomestic)
    }
    
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
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
    
    let blankView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    
//    TradingChartView(chartData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2])
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
//        let ur = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["저장된 URL이 없음"]
//        print(type(of: ur))
//        print(ur)
        self.uiSc.isActive = true
        self.uiSc.isEditing = true
        
        self.tradingView.isHidden = false
        self.tradingChartViewUIView.isHidden = true
        
        self.isDomestic = true
        self.rightButton.title = "국내"
        
    }
    
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
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItems()
        
        self.scrollView.backgroundColor = .white
        self.contentView.backgroundColor = .blue
        self.stackView.backgroundColor = .cyan
        
        view.backgroundColor = .systemBackground
        
        
        let hostingController = UIHostingController(rootView: TradingChartView(chartData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2]) )
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }
//        hostingController.modalPresentationStyle = .popover
//        self.present(hostingController, animated: true)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        self.tradingChartViewUIView.addSubview(hostingController.view)
        hostingController.view.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }

        layout()
        
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
        
//        searchKeyword(searchWord: searchBar.text ?? "")
        print("여기까지 됨")
        //검색을 했을 시, 지역 변수 배열 두가지에 검색한 url에 대하여 값을 append하고, 이를 UserDefaults에도 갱신해준다.
        // OK쪽 콜백으로 옮김
//        self.urlsArr.append(searchBar.text ?? "")
//        self.urlsAlias.append("새로 검색한 url")
//
//        self.urlsArr[0] = ""
//        self.urlsAlias[0] = "별칭"
//        //UserDefaults에도 값 갱신
//        UserDefaults.standard.set(urlsArr, forKey: "urls")
//        UserDefaults.standard.set(urlsAlias, forKey: "urlAlias")
//        let url = searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
//        navigationController?.pushViewController(vc, animated: true)
    }
}



// 키보드 내리기 위한 코드
extension TradingSearchViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}

