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

    
    
    
    private var keywordRankArr: [String] = ["임시 keyword 1", "임시 keyword 2", "임시 keyword 3", "임시 keyword 4", "임시 keyword 5", "임시 keyword 6", "임시 keyword 7", "임시 keyword 8", "임시 keyword 9", "임시 keyword 10"]

    private let uiSc: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
        //화면 어두워지지 않도록 false 처리
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var urlTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.backgroundColor = UIColor(red: 223/255.0, green: 156/255.0, blue: 50/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "splash")!)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

//        let ur = UserDefaults.standard.array(forKey: "urls") as? [String] ?? ["저장된 URL이 없음"]
//        print(type(of: ur))
//        print(ur)
        self.uiSc.isActive = true
        self.uiSc.isEditing = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        
        view.backgroundColor = .systemBackground
        // DataSource, Delegate 설정 시 구분을 위해 tag 설정
        
        attribute()
        layout()
    }
    
    private func setNavigationItems(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "오늘의 Keywords"
//        let searchController = UISearchController()
//        searchController.searchBar.placeholder = "요청 URL을 입력해주세요"
//        //화면 어두워지지 않도록 false 처리
        uiSc.obscuresBackgroundDuringPresentation = false
        uiSc.searchBar.delegate = self
        
        // embed UISearchController
        navigationItem.searchController = uiSc
    }
    
    private func attribute(){
//        button.setTitle("요청 URL 입력", for: .normal)
//        button.backgroundColor = .lightGray
//        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
    }
    
    @objc func pushVC(){
        let vc = ShowDataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func layout(){
        [ urlTableView].forEach{
            view.addSubview($0)
        }
        
        urlTableView.snp.makeConstraints{
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension KeywordRankViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //이전 검색이 있었을 경우에, DidEndEditing에서 stations리스트를 비워두었고 tableView는 그대로이기 때문에
        // reloadData() 해주지 않으면 이전 검색 내역이 그대로 tableView에 남아있다.
        urlTableView.reloadData()
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
        
        searchKeyword(searchWord: searchBar.text ?? "")
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





//TableView에 대한 delegate설정
extension KeywordRankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return keywordRankArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // addHeaderTableView
//        if tableView.tag == 1{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddHeaderViewCell", for: indexPath) as? AddHeaderViewCell else { return UITableViewCell() }
//            return cell
//        }

        // urlTableView
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        // 첫 cell에는 현재 검색하고있는 내용을 실시간으로 작성해줄 것이다.

//        if indexPath.row == 0 {
//            let url = "검색url"
//            let url_alias = "검색중"
//            cell.textLabel?.text = url_alias
//            cell.detailTextLabel?.text = url
//            return cell
//        }
            let keyword = keywordRankArr[indexPath.row ]

            cell.textLabel?.text = keyword
        cell.detailTextLabel?.text = "Rank " + String(indexPath.row + 1)
            return cell


    }
}

extension KeywordRankViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let keyword = keywordRankArr[indexPath.row]
        searchKeyword(searchWord: keyword)
//        let vc = ShowDataViewController()
//        vc.setup(apiUrl: url)
//        navigationController?.pushViewController(vc, animated: true)
        
        //TODO: 여기서 채팅창에 url을 넘겨줘야함

    }
}


//검색창에 검색하거나 화면 순위tableView에서 클릭한 keyword 검색
extension KeywordRankViewController {
    private func searchKeyword(searchWord: String){
        print("getSearchword 호출" + searchWord)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            print("정보 다 받아왔나?")
            print("차트 조회 버튼 클릭")
            // SwiftUI View를 출력하려면 UIHostingController로 감싸서 띄워야한다.
           
            let hostingController = UIHostingController(rootView: KeywordScoreGraphViewController(keyword: searchWord))
            if #available(iOS 16.0, *) {
                hostingController.sizingOptions = .preferredContentSize
            } else {
                // Fallback on earlier versions
            }
            hostingController.modalPresentationStyle = .popover
            self.navigationController?.pushViewController(hostingController, animated: true)
//            self.present(hostingController, animated: true)
        }
    }
}


