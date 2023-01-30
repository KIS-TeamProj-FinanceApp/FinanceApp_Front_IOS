//
//  PortFolioPieChartView.swift
//  FinanceApp_Front_IOS
//
//  Created by 양준식 on 2023/01/29.
//

import SwiftUI
import Charts


struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count){ i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[i])
                        Text(self.percents[i])
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}



struct PieSliceView: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.5,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                Text(pieSliceData.text)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}



struct PortFolioPieChartView: View {
    public var values: [Double]
    public var colors: [Color]
    public var names: [String]
    
    public var backgroundColor: Color
    public var innerRadiusFraction: CGFloat
        
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count){ i in
                        PieSliceView(pieSliceData: self.slices[i])
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                    
                    VStack {
                        Text("Total")
                            .font(.title)
                            .foregroundColor(Color.gray)
                        Text(String(values.reduce(0, +)))
                            .font(.title)
                    }
                }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 10, trailing: 0))
                
                PieChartRows(colors: self.colors, names: self.names, values: self.values.map { String($0) }, percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}



struct PortFolioPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PortFolioPieChartView(values: [100, 500, 300], colors: [Color.blue, Color.green, Color.orange], names: ["Rent", "Transport", "Education"], backgroundColor: Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0), innerRadiusFraction: 0.6)
    }
}
