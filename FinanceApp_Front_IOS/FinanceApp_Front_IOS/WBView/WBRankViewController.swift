//
//  WBRankViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

class WBRankViewController: UIViewController {
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    // 투자자'S now에 들어갈 Data를 담을 배열
    private var nowTop12: [SecurityForRecommend] = [
        SecurityForRecommend(securityName: "현재 1위", sector: "업종1"),
        SecurityForRecommend(securityName: "현재 2위", sector: "업종2"),
        SecurityForRecommend(securityName: "현재 3위", sector: "업종3"),
        SecurityForRecommend(securityName: "현재 4위", sector: "업종1"),
        SecurityForRecommend(securityName: "현재 5위", sector: "업종3"),
        SecurityForRecommend(securityName: "현재 6위", sector: "업종1"),
        SecurityForRecommend(securityName: "현재 7위", sector: "업종1"),
        SecurityForRecommend(securityName: "현재 8위", sector: "업종2"),
        SecurityForRecommend(securityName: "현재 9위", sector: "업종5"),
        SecurityForRecommend(securityName: "현재 10위", sector: "업종6"),
        SecurityForRecommend(securityName: "현재 11위", sector: "업종7"),
        SecurityForRecommend(securityName: "현재 12위", sector: "업종4"),
           ]
    
    // 투자자'S Future에 들어갈 Data를 담을 배열
    private var futureTop12: [SecurityForRecommend] = [
        SecurityForRecommend(securityName: "Future 1위", sector: "업종1"),
        SecurityForRecommend(securityName: "Future 2위", sector: "업종1"),
        SecurityForRecommend(securityName: "Future 3위", sector: "업종2"),
        SecurityForRecommend(securityName: "Future 4위", sector: "업종3"),
        SecurityForRecommend(securityName: "Future 5위", sector: "업종2"),
        SecurityForRecommend(securityName: "Future 6위", sector: "업종2"),
        SecurityForRecommend(securityName: "Future 7위", sector: "업종1"),
        SecurityForRecommend(securityName: "Future 8위", sector: "업종3"),
        SecurityForRecommend(securityName: "Future 9위", sector: "업종4"),
        SecurityForRecommend(securityName: "Future 10위", sector: "업종6"),
        SecurityForRecommend(securityName: "Future 11위", sector: "업종7"),
        SecurityForRecommend(securityName: "Future 12위", sector: "업종5")]
    
    private var sectorArr: [String] = ["업종1", "업종2", "업종3", "업종4", "업종5", "업종6", "업종7"]
    private var sectorCheckArr: [Bool] = [true, true, true, true, true, true, true]
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    
    let header = WBRankHeaderView()
    
    //여기에 ""'s NOW를 앞,뒤 나누어 addSubview해야함
    private lazy var nowLabel: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = .green
        return uiview
    }()
    //여기에 ""'s Future를 앞,뒤 나누어 addSubview해야함
    private lazy var futureLabel: UIView = {
        let uiview = UIView()
        uiview.backgroundColor = .blue
        return uiview
    }()
    
    // 섹터 선택을 위한 collectionView
    private lazy var sectorCollectionView: UICollectionView = {
        let cv = UICollectionView()
        
        
        return cv
    }()
    
    
    private lazy var rankTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WBRankTableViewCell.self, forCellReuseIdentifier: "WBRankTableViewCell")
        tableView.tag = 0
        tableView.rowHeight = 60
//        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
        tableView.backgroundColor = .cyan
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var rankTableView2: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
        tableView.register(WBRankTableViewCell.self, forCellReuseIdentifier: "WBRankTableViewCell")
        tableView.tag = 1
        tableView.rowHeight = 60
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .lightGray
        return tableView
    }()
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //네비게이션바 숨기기 여기서 불가능
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "오늘의 Keyrds"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        //navigationBar 숨기기는 viewDidLoad에서 해줘야한다.
        self.navigationController?.isNavigationBarHidden = true
        attribute()
        layout()
    }
    
    
    
    private func attribute(){
    }
    

    private func layout(){
        [ header, nowLabel, futureLabel, rankTableView, rankTableView2].forEach{
            view.addSubview($0)
        }

        header.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview()
        }
        
        nowLabel.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.size.width  / 2)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview()
        }
        
        futureLabel.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.size.width  / 2)
            $0.height.equalTo(40)
            $0.leading.equalTo(nowLabel.snp.trailing)
        }
        
        rankTableView.snp.makeConstraints{
            $0.top.equalTo(nowLabel.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.size.width  / 2)
            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview().inset(UIScreen.main.bounds.size.width  / 2)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        rankTableView2.snp.makeConstraints{
            $0.top.equalTo(nowLabel.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.size.width  / 2)
            $0.leading.equalTo(rankTableView.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

// 키보드 내리기 위한 코드
extension WBRankViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}

//TableView에 대한 delegate설정
extension WBRankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        // 왼쪽 tableView
        if tableView.tag == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WBRankTableViewCell", for: indexPath) as? WBRankTableViewCell else { return UITableViewCell() }
            cell.setup(rank: indexPath.row, securityName: nowTop12[indexPath.row].securityName)
            cell.selectionStyle = .none
            return cell
        }
        //오른쪽 tableView
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WBRankTableViewCell", for: indexPath) as? WBRankTableViewCell else { return UITableViewCell() }
            cell.setup(rank: indexPath.row, securityName: futureTop12[indexPath.row].securityName)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension WBRankViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
//        let url = urlsArr[indexPath.row]
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
//        navigationController?.pushViewController(vc, animated: true)

        //TODO: 여기서 채팅창에 url을 넘겨줘야함

    }
}
