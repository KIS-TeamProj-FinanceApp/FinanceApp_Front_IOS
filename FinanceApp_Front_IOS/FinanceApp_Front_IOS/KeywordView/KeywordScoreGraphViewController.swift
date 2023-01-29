//
//  KeywordScoreGraphViewController.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/22.
//


import SwiftUI
import Charts

struct KeywordScoreGraphViewController: View {
    
    private let title: String
   
    init(keyword: String){
        title = keyword
    }
    
    var body: some View {
        ScrollView{

            VStack{
                KeywordChartView(chartData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2])
//                    .padding(.vertical)
                    .padding( EdgeInsets(top: 30, leading: 0, bottom: 50, trailing: 0))
                
                VStack(spacing: 20) {
                  Text("hi")
                    Spacer()
                    Text("hi")
                    Divider()
                    Text("hihi")
                }
            }
            
            
        }
        .navigationTitle(title)
        
        
    }
    
    
    
}

struct KeywordScoreGraphViewController_Previews: PreviewProvider {
    static var previews: some View {
        KeywordScoreGraphViewController(keyword: "키워드이름")

    }
}

extension KeywordScoreGraphViewController{
    private var navigationBarTrailingItems: some View {
        HStack{
            Text("키워드 이름".uppercased())
                .font(.headline)
                .foregroundColor(Color.pink)
//            Image(uiImage: UIImage(named: "one")!)
        }
    }
}
