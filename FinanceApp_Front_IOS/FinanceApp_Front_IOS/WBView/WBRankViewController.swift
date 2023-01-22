//
//  WBRankViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

class WBRankViewController: UIViewController {
    
    let header = WBRankHeaderView()
    
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
        [ header].forEach{
            view.addSubview($0)
        }

        header.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview()
        }
    }
}


extension WBRankViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
}
