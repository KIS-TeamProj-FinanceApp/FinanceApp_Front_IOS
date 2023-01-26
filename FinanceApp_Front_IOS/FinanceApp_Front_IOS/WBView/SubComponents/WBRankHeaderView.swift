//
//  WBRankHeaderView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//

import UIKit

class WBRankHeaderView: UIView {
    
    // ----------------------------------------- Variables ---------------------------------------- //
    
    // 우리가 제공할 투자자들의 목록
    private let investorList: [String] = ["Berkshire hathaway", "Ray Dalio", "Goldman Sachs", "Black Rock"]
    // 지금 선택한 투자자를 담을 변수
    private var selectedInvestor: String = ""
    
    // ----------------------------------------- Variables ---------------------------------------- //
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    
    private lazy var investorTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 3.0
        tf.layer.borderColor = UIColor(red: 0/255, green: 192/255, blue: 235/255, alpha: 1).cgColor
        tf.layer.cornerRadius = 10.0
        tf.backgroundColor = .systemBackground
        tf.placeholder = "투자자 선택"
        //textField 앞에 inset을 줘서 text가 자연스럽게 보이도록
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    private lazy var investorLabel: UILabel = {
        let label = UILabel()
        label.text = "  'S PICK"
        label.font = .systemFont(ofSize: 34.0, weight: .semibold)
        return label
    }()
    
    private lazy var investorPicker: UIPickerView = {
        let pv = UIPickerView()
        pv.frame = CGRect(x: 2000, y: 2000, width: 200, height: 200)
        //숨겨놔야함
//        pv.isHidden = true
        pv.delegate = self
        pv.dataSource = self

        return pv
    }()
    
    
    
    // ------------------------------------------------------- UI Components ------------------------------------------------------ //
    
    func createToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexibleSpace,doneBtn], animated: false)
        investorTextField.inputAccessoryView = toolBar
    }
    
    @objc private func dismissKeyboard(){
        self.investorTextField.endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.investorTextField.inputView = self.investorPicker
        createToolBar()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        [investorTextField, investorLabel].forEach{
            self.addSubview($0)
        }
        
        investorTextField.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(UIScreen.main.bounds.size.width  / 2)
//            $0.centerX.equalToSuperview().inset(UIScreen.main.bounds.size.width / 3)
            $0.height.equalToSuperview().inset(8)
            $0.width.equalTo(120)
//            $0.top.equalToSuperview().inset(10)
//            $0.leading.equalToSuperview().inset(30)
            
        }
        
        investorLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(investorTextField.snp.trailing)
        }
    }
}



extension WBRankHeaderView: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return investorList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return investorList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select\(investorList[row])")
        self.selectedInvestor = investorList[row]
        investorTextField.text = investorList[row]
    }
}
