//
//  TradingChartView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import SwiftUI


struct TradingChartView: View {
    
    
    private let data: [Double]
    //이평선을 위해
    private let data2: [Double]
    //그래프에서 Y축 수치를 알아서  알맞은 사이즈로 그래프를 그리기 위해 Data에서 Y축값
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingData: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(chartData: [Double]){
        self.data = chartData
        self.data2 =  [100.0, 105.2,100.0, 105.2,100.0, 105.2,100.0, 105.2,100.0, 105.2]
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.green : Color.red
        
        endingDate = Date()
        startingData = endingDate.addingTimeInterval(-7*24*60*60)
        
        
    }
    
    //300
    //100
    // 3
    
    var body: some View {
        
        VStack {
            keywordChartView
                .frame(height: 200)
            .background( chartBackground )
            .overlay( chartYAxis.padding(.horizontal, 4) , alignment: .leading )
            
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.secondary)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                withAnimation(.linear(duration:  2.0)){
                    percentage = 1.0
                }
            }
        }
//        .background(Color(UIColor.black))
        
    }
}



extension TradingChartView {
    
    private var keywordChartView: some View {
        GeometryReader { geometry in
            Path{ path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    //최대, 최솟값의 차를 y축 길이로
                    let yAxis = maxY - minY
                    //지금 data의 y축 위치 지정 (비율로), 그리고나서 전체 height곲해줌
                    let yPosition = CGFloat((data[index] - minY) / yAxis) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round) )
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
            //두개의 그래프를 함께 그림
            Path{ path in
                for index in data2.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data2.count) * CGFloat(index + 1)
                    //최대, 최솟값의 차를 y축 길이로
                    let yAxis = maxY - minY
                    //지금 data의 y축 위치 지정 (비율로), 그리고나서 전체 height곲해줌
                    let yPosition = CGFloat((data2[index] - minY) / yAxis) * geometry.size.height - 50
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(Color(UIColor.blue), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round) )
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
        
    }
    

    
    private var chartBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack{
            Text(maxY.formatted( .number))
            Spacer()
            Text(((maxY + minY) / 2).formatted(.number))
            Spacer()
            Text(minY.formatted(.number))
        }
    }
    
    private var chartDateLabels: some View {
        HStack{
            Text(startingData.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
struct TradingChartView_Previews: PreviewProvider {
    static var previews: some View {
        TradingChartView(chartData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2])

    }
}

