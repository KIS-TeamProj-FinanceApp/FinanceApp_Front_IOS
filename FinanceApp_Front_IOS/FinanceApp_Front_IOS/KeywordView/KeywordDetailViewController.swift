//
//  KeywordDetailViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/02/01.
//

import UIKit
import SnapKit
import SwiftUI

class KeywordDetailViewController: UIViewController {

    private var keyStockTitle: String = "한국금융지주"
    private var newsArr: [String] = ["기사제목1", "기사제목2", "기사제목3", "기사제목4", "기사제목5"]
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    private lazy var issueScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Issue Score"
        label.font = .systemFont(ofSize: 34.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var graphUIView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        return uiView
    }()
    
    
    private lazy var pnLabel1: UILabel = {
        let label = UILabel()
        label.text = "이 종목에 대해 기사는"
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var pnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var pnLabel2: UILabel = {
        let label = UILabel()
        label.text = "100%"
        label.font = .systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private lazy var pnLabel3: UILabel = {
        let label = UILabel()
        label.text = "확률로"
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var pnLabel4: UILabel = {
        let label = UILabel()
        label.text = "긍정적"
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = .red
        return label
    }()
    private lazy var pnLabel5: UILabel = {
        let label = UILabel()
        label.text = "입니다"
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.text = "뉴스기사"
        label.font = .systemFont(ofSize: 30.0, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.rowHeight = 80
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var chartHostingController: UIHostingController = {
        
        let hostingController = UIHostingController( rootView: KeywordChartSwiftUIView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], startDate: Date(), endDate: Date()) )
        
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
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        requestAPI_DomesticPrice_now(jongmokName: "한국금융지주")
//        requestAPI_DomesticPrice_former(dayWeekMonth: "D")
//        requestAPI_DomesticPrice_former(dayWeekMonth: "W")
//        requestAPI_DomesticPrice_former(dayWeekMonth: "M")  
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            // -------------------------------------------- 바꾸는 부분 ----------------------------------------------- //
            self.chartHostingController.view.snp.removeConstraints()
            self.chartHostingController = UIHostingController(rootView:  KeywordChartSwiftUIView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], startDate: Date(), endDate: Date()))
//            self.domesticHostingController.rootView = PortFolioPieChartView(values: [1300, 500, 300, 100, 200], colors: [Color.blue, Color.green, Color.orange, Color.red, Color.cyan], names: ["Rent", "Transport", "Education", "1", "2"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
            
            if #available(iOS 16.0, *) {
                self.chartHostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }

            self.addChild(self.chartHostingController)
            self.chartHostingController.view.translatesAutoresizingMaskIntoConstraints = false
            
//            self.domesticHostingController.view.snp.removeConstraints()
    
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
        
        [ issueScoreLabel, graphUIView, pnLabel1, pnStackView, newsLabel, newsTableView].forEach{
//            view.addSubview($0)
            stackView.addArrangedSubview($0)
        }
        
        issueScoreLabel.snp.makeConstraints{
//            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
//            $0.height.equalTo(60)
        }
     
        
        graphUIView.snp.makeConstraints{
//            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        pnLabel1.snp.makeConstraints{
            $0.top.equalTo(graphUIView.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        pnStackView.snp.makeConstraints{
            $0.top.equalTo(pnLabel1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        [pnLabel2, pnLabel3, pnLabel4, pnLabel5].forEach{
            pnStackView.addArrangedSubview($0)
        }
        
        pnLabel2.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        pnLabel3.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(pnLabel2.snp.trailing)
        }
        
        pnLabel4.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(pnLabel3.snp.trailing)
        }
        
        pnLabel5.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(pnLabel4.snp.trailing)
        }
        
        newsLabel.snp.makeConstraints{

            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        
        newsTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80 * 5)
        }
        
    }
}


//TableView에 대한 delegate설정
extension KeywordDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return keywordRankArr.count
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        cell.setup(newsTitle: newsArr[indexPath.row])
        return cell
    }
}

extension KeywordDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
