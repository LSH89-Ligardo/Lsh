//
//  ContentView.swift
//  ChartDemo
//
//  Created by Jungman Bae on 1/15/25.
//

import SwiftUI
import Charts

struct MonthlyTemp: Identifiable {
    var id = UUID()
    var month: String
    var degrees: Int
    var year: String
}

let tempData: [MonthlyTemp] = [
    MonthlyTemp(month: "Jan", degrees: 50, year: "2021"),
    MonthlyTemp(month: "Feb", degrees: 43, year: "2021"),
    MonthlyTemp(month: "Mar", degrees: 61, year: "2021"),
    MonthlyTemp(month: "Jan", degrees: 30, year: "2022"),
    MonthlyTemp(month: "Feb", degrees: 38, year: "2022"),
    MonthlyTemp(month: "Mar", degrees: 29, year: "2022")
]

struct ContentView: View {
    var body: some View {
        Chart(tempData) { data in
//            AreaMark(
//                x: .value("Month", data.month),
//                y: .value("Temp", data.degrees)
//            )
//            RectangleMark(
//                x: .value("Month", data.month),
//                y: .value("Temp", data.degrees)
//            )
            LineMark(
                x: .value("Month", data.month),
                y: .value("Temp", data.degrees)
            )
            .interpolationMethod(.cardinal)
            .foregroundStyle(by: .value("Year", data.year))
            .symbol(by: .value("Year", data.year))
        }
        .chartPlotStyle { plotArea in
            plotArea.background(.gray.opacity(0.3))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
