//
//  TradingChartView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/30.
//

import SwiftUI


struct TradingChartView: View {
    
    
    private let dailyData: [Double]
    //주간 이평선을 위해
    private let weeklyData: [Double]
    //월간 이평선을 위해
    private let monthlyData: [Double]
    
    
    //그래프에서 Y축 수치를 알아서  알맞은 사이즈로 그래프를 그리기 위해 Data에서 Y축값
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingData: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    
    init(dailyData: [Double], weeklyData: [Double], monthlyData: [Double], startDate: Date, endDate: Date ){
        self.dailyData = dailyData
        self.weeklyData =  weeklyData
        self.monthlyData = monthlyData
        
        maxY = max((dailyData.max() ?? 0), (weeklyData.max() ?? 0), (monthlyData.max() ?? 0) )
        minY = min((dailyData.min() ?? Double(1e9)), (weeklyData.min() ?? Double(1e9)), (monthlyData.min() ?? Double(1e9)) )
        
        let priceChange = (dailyData.last ?? 0) - (dailyData.first ?? 0)
//        lineColor = priceChange > 0 ? Color.pink : Color.red
//        lineColor = Color( uiColor: UIColor(red: 255.0 / 255.0, green: 165.0 / 255.0, blue: 195 / 255.0, alpha: 1.0))
        lineColor = Color( uiColor: UIColor.systemPink)
        endingDate = endDate
        startingData = startDate
    }
    
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
                for index in dailyData.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(dailyData.count) * CGFloat(index + 1)
                    //최대, 최솟값의 차를 y축 길이로
                    let yAxis = maxY - minY
                    //지금 data의 y축 위치 지정 (비율로), 그리고나서 전체 height곲해줌
                    let yPosition = CGFloat((dailyData[index] - minY) / yAxis) * geometry.size.height
                    
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
            
//            두개의 그래프를 함께 그림
//             주간 이평선
            Path{ path in
                for index in weeklyData.indices {

                    let xPosition = geometry.size.width / CGFloat(weeklyData.count) * CGFloat(index + 1)
                    //최대, 최솟값의 차를 y축 길이로
                    let yAxis = maxY - minY
                    //지금 data의 y축 위치 지정 (비율로), 그리고나서 전체 height곲해줌
                    let yPosition = CGFloat((weeklyData[index] - minY) / yAxis) * geometry.size.height

                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(Color( uiColor: UIColor(red: 225.0 / 255.0, green: 235.0 / 255.0, blue: 195 / 255.0, alpha: 1.0)), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round) )
//            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
//            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
//            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
//            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
            
           
            // 월간 이평선
            Path{ path in
                for index in monthlyData.indices {

                    let xPosition = geometry.size.width / CGFloat(monthlyData.count) * CGFloat(index + 1)
                    //최대, 최솟값의 차를 y축 길이로
                    let yAxis = maxY - minY
                    //지금 data의 y축 위치 지정 (비율로), 그리고나서 전체 height곲해줌
                    let yPosition = CGFloat((monthlyData[index] - minY) / yAxis) * geometry.size.height

                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(Color( uiColor: UIColor(red: 185.0 / 255.0, green: 205.0 / 255.0, blue: 245 / 255.0, alpha: 1.0)), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round) )
//            .shadow(color: Color(UIColor.black), radius: 10, x: 0.0, y: 10)
//            .shadow(color: Color(UIColor.black).opacity(0.5), radius: 10, x: 0.0, y: 20)
//            .shadow(color: Color(UIColor.black).opacity(0.2), radius: 10, x: 0.0, y: 30)
//            .shadow(color: Color(UIColor.black).opacity(0.1), radius: 10, x: 0.0, y: 40)
 
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
        TradingChartView(dailyData: [100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2,100.1, 103.2, 107.2, 102.1, 104.2, 108.2, 10.1, 101.2, 10.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2, 100.1, 103.2, 105.2], weeklyData: [100.0, 105.2,101.0, 105.2,100.0, 105.2,100.0, 105.2,100.0, 105.2], monthlyData: [110.0, 115.2,111.0, 115.2,110.0, 125.2,120.0, 125.2,120.0, 125.2], startDate: Date(), endDate: Date())

    }
}

