//
//  TradingViewcontroller.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit
import SwiftUI

//이 viewController는 swiftUI를 이용한 GraphView를 띄워주기 위한 다리 역할만 함.
class TradingViewController: UIViewController{
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationController?.isNavigationBarHidden = true

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let hostingController = UIHostingController(rootView: TradingGraphViewController())
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }
        hostingController.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(hostingController, animated: true)
//        self.present(hostingController, animated: true)
    }

}

