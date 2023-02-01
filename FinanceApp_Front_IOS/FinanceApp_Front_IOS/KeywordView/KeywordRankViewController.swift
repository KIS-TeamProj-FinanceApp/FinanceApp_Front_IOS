//
//  KeywordRankViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//


import UIKit
import SnapKit
import Alamofire
import SwiftUI

class KeywordRankViewController: UIViewController {
    
    
    // Identifiable 프로토콜을 따르는 [SecurityInfo] 배열, SwiftUI view로 넘겨줘야함
    private var securityInfoArr: [SecurityInfo] = []
    // SiteView를 따르는 것 시가/종가/ 최저가 /최고가
    private var mkpInfoArr: [SiteView] = []
    private var clprInfoArr: [SiteView] = []
    private var hiprInfoArr: [SiteView] = []
    private var loprInfoArr: [SiteView] = []

    
    
    
    private var keywordRankArr: [String] = ["keyword 1", "keyword 2", "keyword 3", "keyword 4", "keyword 5", "keyword 6", "keyword 7", "keyword 8", "keyword 9", "keyword 10"]

    private let uiSc: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "KeyStock 검색"
        //화면 어두워지지 않도록 false 처리
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var keywordTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(KeywordRankTableViewCell.self, forCellReuseIdentifier: "KeywordRankTableViewCell")
        tableView.rowHeight = 60
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.uiSc.isActive = true
        self.uiSc.isEditing = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Today's KeyStocks"
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
        uiSc.obscuresBackgroundDuringPresentation = false
        uiSc.searchBar.delegate = self
        
        // embed UISearchController
        navigationItem.searchController = uiSc
    }
    
    private func layout(){
        [ keywordTableView].forEach{
            view.addSubview($0)
        }
        
        keywordTableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension KeywordRankViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //이전 검색이 있었을 경우에, DidEndEditing에서 stations리스트를 비워두었고 tableView는 그대로이기 때문에
        // reloadData() 해주지 않으면 이전 검색 내역이 그대로 tableView에 남아있다.
        keywordTableView.reloadData()
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
        
        searchKeyword(searchWord: searchBar.text ?? "한국금융지주")
        print("여기까지 됨")
        //검색을 했을 시, 지역 변수 배열 두가지에 검색한 url에 대하여 값을 append하고, 이를 UserDefaults에도 갱신해준다.
        // OK쪽 콜백으로 옮김
    }
    
}





//TableView에 대한 delegate설정
extension KeywordRankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return keywordRankArr.count
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordRankTableViewCell", for: indexPath) as? KeywordRankTableViewCell else { return UITableViewCell() }
        
        cell.setup(rank: String(indexPath.row + 1), stock: keywordRankArr[indexPath.row])
        return cell
    }
}

extension KeywordRankViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let keyword = keywordRankArr[indexPath.row]
        searchKeyword(searchWord: keyword)
    }
}


//검색창에 검색하거나 화면 순위tableView에서 클릭한 keyword 검색
extension KeywordRankViewController {
    private func searchKeyword(searchWord: String){
        print("getSearchword 호출" + searchWord)
        
        self.navigationController?.pushViewController(KeywordDetailViewController(), animated: true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
//            let hostingController = UIHostingController(rootView: KeywordScoreGraphViewController(keyword: searchWord))
//            if #available(iOS 16.0, *) {
//                hostingController.sizingOptions = .preferredContentSize
//            } else {
//                // Fallback on earlier versions
//            }
//            hostingController.modalPresentationStyle = .popover
//            self.navigationController?.pushViewController(hostingController, animated: true)
////            self.present(hostingController, animated: true)
//        }
    }
}


