//
//  NewsTableViewCell.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/02/01.
//

import UIKit
import SnapKit

final class NewsTableViewCell: UITableViewCell {
    
    private lazy var imageButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        btn.tintColor = UIColor(red: 233/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        return btn
    }()
    
    private lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "기사 제목"
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout(){
        [imageButton, newsTitleLabel].forEach{
            addSubview($0)
        }
        
        imageButton.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        newsTitleLabel.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(imageButton.snp.trailing).offset(10)
        }
        
    }
    
    func setup(newsTitle: String){
        self.newsTitleLabel.text = newsTitle
    }
}

