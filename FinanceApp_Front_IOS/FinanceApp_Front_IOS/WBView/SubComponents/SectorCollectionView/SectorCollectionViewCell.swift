//
//  SectorCollectionViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit


class SectorCollectionViewCell: UICollectionViewCell{
    
    private lazy var titleButton = UIButton()
    
    private var isClicked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        titleButton.backgroundColor = .lightGray
        //        titleButton.layer.cornerRadius = 12.0
        titleButton.layer.borderWidth = 1.0
        titleButton.layer.borderColor = UIColor.lightGray.cgColor
        titleButton.layer.cornerRadius = 6.0
        titleButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        //        titleButton.isEnabled = false
    }
    
    private func layout() {
        [ titleButton].forEach{ addSubview($0)}
        
        titleButton.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func btnClicked(){
        if self.isClicked{
            self.titleButton.backgroundColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 186/255.0, alpha: 1.0)
        }
        else{
            self.titleButton.backgroundColor = .lightGray
        }
        self.isClicked = !self.isClicked
        
        //TODO: 클릭시, viewController의 Array와 연동하도록 해야함
        //버튼 클릭 시, 버튼클릭여부 Bool 값을 반대로 바꾸라고 신호를 보내줘야함
        //        NotificationCenter.default.post(name: .cellColorChange, object: nil, userInfo: ["row": rowNum, "col": colNum])
    }
    
    
    
    // firstColumn인 경우에는 인덱스 번호를( 날짜 정보를 다 받아와줄 수는 없다. json에 날짜가 없을 수 있으니), firstRow인 경우에는 column이름들을 출력해줘야할 것이다.
    // FirstColumn 혹은 FirstRow인 경우에는 모드 Clickable,  둘 다 False인 경우에는 모두 UnClickable이어야한다.
    func setup( title: String, isClicked: Bool){
        
        titleButton.setTitle(title, for: .normal)
        //클릭 가능하게
        titleButton.isEnabled = true
        
        self.isClicked = isClicked
        // 클릭 상태면 파란색으로
        if isClicked{
            titleButton.backgroundColor = UIColor(red: 253/255.0, green: 166/255.0, blue: 186/255.0, alpha: 1.0)
        }//클릭 X 상태면 밝은 회색
        else{
            titleButton.backgroundColor = .lightGray
        }
        
    }
    
}
