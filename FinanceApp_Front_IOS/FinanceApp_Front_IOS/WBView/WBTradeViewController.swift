//
//  WBTradeViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SnapKit
import Alamofire

class WBTradeViewController: UIViewController {
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    private var nowSecurity: SecurityForRecommend?
    
    // ------------------------------------------------------- variables ------------------------------------------------------ //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    //여기에 ""'s NOW를 앞,뒤 나누어 addSubview해야함
    private lazy var securityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "종목명"
        label.textColor = .black
        return label
    }()
    
    //여기에 ""'s Future를 앞,뒤 나누어 addSubview해야함
    private lazy var securityValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationBar 숨기기는 viewDidLoad에서 해줘야한다.
        self.navigationController?.isNavigationBarHidden = true
        attribute()
        layout()
    }
    
    private func attribute(){
    }

    private func layout(){
        [securityNameLabel, securityValueLabel].forEach{
            view.addSubview($0)
        }

        securityNameLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(60)
            $0.width.equalTo(120)
            $0.leading.equalToSuperview()
        }
        
        securityValueLabel.snp.makeConstraints{
            $0.top.equalTo(securityNameLabel.snp.top)
            $0.height.equalTo(60)
            $0.width.equalTo(120)
            $0.leading.equalTo(securityNameLabel.snp.trailing)
        }
    }
    
    func setup(security: SecurityForRecommend){
        self.nowSecurity = security
        securityValueLabel.text = security.securityName
    }
}
