//
//  MyAccountMoneyView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/25.
//

import UIKit

//140 높이로 MyAccountViewController에서 사용할 것이다.
class MyAccountMoneyView: UIView {
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    
    // --------------------------------------------------------- Variables -------------------------------------------------------- //
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    //평가금액
    private lazy var pyunggagumTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "평가금액"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        return label
    }()
    
    private lazy var pyunggagumTotalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "00000원"
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    // 매입금액합계
    private lazy var maeipgumTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "매입금액합계"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        return label
    }()
    
    private lazy var maeipgumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    
    //가운데 border 바
    let borderView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    //예수금 총액
    private lazy var yesugumTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "예수금총액"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        return label
    }()
    
    private lazy var yesugumTotalValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    // D+2 예수금
    private lazy var D2YesugumTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "D+2예수금"
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        return label
    }()
    
    private lazy var D2YesugumValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0원"
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    

    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
       
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [pyunggagumTotalLabel, pyunggagumTotalValueLabel, maeipgumTotalLabel, maeipgumValueLabel, borderView, yesugumTotalLabel, yesugumTotalValueLabel, D2YesugumTotalLabel, D2YesugumValueLabel].forEach{
            self.addSubview($0)
        }
        
        borderView.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(2)
            $0.centerX.centerY.equalToSuperview()
        }
        
        
        pyunggagumTotalLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        pyunggagumTotalValueLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalTo(borderView.snp.leading).offset(-10)
        }
        
        maeipgumTotalLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(10)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        maeipgumValueLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalTo(borderView.snp.leading).offset(-10)
        }
        
        
        
        yesugumTotalLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(borderView.snp.trailing).offset(10)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        yesugumTotalValueLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        D2YesugumTotalLabel.snp.makeConstraints{
//            $0.top.equalTo(yesugumTotalLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalTo(borderView.snp.trailing).offset(10)
//            $0.height.equalToSuperview().inset(4)
//            $0.width.equalTo(120)
        }
        
        D2YesugumValueLabel.snp.makeConstraints{
//            $0.top.equalTo(yesugumTotalLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupTitle(leftTopTitle: String, leftBottomTitle: String, rightTopTitle: String, rightBottomTitle: String) {
        self.pyunggagumTotalLabel.text = leftTopTitle
        self.maeipgumTotalLabel.text = leftBottomTitle
        self.yesugumTotalLabel.text = rightTopTitle
        self.D2YesugumTotalLabel.text = rightBottomTitle
    }
    
    func setupValue(pyunggagumTotal: String, maeipgum: String, yesugumTotal: String, D2Yesugum: String) {
        self.pyunggagumTotalValueLabel.text = pyunggagumTotal
        self.maeipgumValueLabel.text = maeipgum
        self.yesugumTotalValueLabel.text = yesugumTotal
        self.D2YesugumValueLabel.text = D2Yesugum
    }
}
