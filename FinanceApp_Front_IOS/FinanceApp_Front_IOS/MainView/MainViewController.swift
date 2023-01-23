//
//  MainViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/20.
//

import UIKit


class MainViewController: UIViewController {
    
    
  
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "병무"
        
        return label
    }()
    
   
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        attribute()
        layout()
    }
    
    
    
    private func attribute(){

    }
    

    private func layout(){
        [ tempLabel].forEach{
            view.addSubview($0)
        }

        tempLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
