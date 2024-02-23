//
//  HistoryGraphView.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//

import SwiftUI
import SwiftData
import Charts

struct HistoryGraphView: View {
  @Query(sort: \Attempt.date) var attempts: [Attempt]
  
  func findDomain() -> TimeInterval {
    if let earliestAttempt = attempts.first {
      let difference = Date.now.timeIntervalSince(earliestAttempt.date)
      return difference / 2
    }
    
    return 30
  }
  
  var body: some View {
    ScrollView {
      VStack (spacing: 20) {
        SummaryStats(attempts: attempts)
        VStack(alignment: .leading) {
          Text("Precision Over Time")
            .font(.title3)
            .bold()
          Chart(attempts) {
            LineMark(
              x: .value("Date", $0.date),
              y: .value("Precision", (1 - $0.errorPercent) * 100)
            ).symbol(.circle)
          }
          .historyChartView()
          .chartScrollPosition(initialX: Date.now)
          .chartXVisibleDomain(length: findDomain())
          .chartYAxis {
            AxisMarks(
              format: Decimal.FormatStyle.Percent.percent.scale(1)
            )
          }
        }
        
        VStack (alignment: .leading) {
          Text("Precision and BPM")
            .font(.title3)
            .bold()
          Chart (attempts){
            PointMark(
              x: .value("BPM", $0.bpm),
              y: .value("Precision", (1 - $0.errorPercent) * 100)
            ).symbol(.circle)
          }
          .historyChartView()
          .chartScrollPosition(initialX: 120)
          .chartXVisibleDomain(length: 300)
          .chartYAxis {
            AxisMarks(
              format: Decimal.FormatStyle.Percent.percent.scale(1)
            )
          }
        }
        
        VStack (alignment: .leading) {
          Text("Precision and Game Length")
            .font(.title3)
            .bold()
          Chart (attempts){
            PointMark(
              x: .value("Game Length", $0.attemptLength),
              y: .value("Precision", (1 - $0.errorPercent) * 100)
            )
          }
          .chartYAxis {
            AxisMarks(
              format: Decimal.FormatStyle.Percent.percent.scale(1)
            )
          }
        }
      }
      .padding()
    }
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Attempt.self, configurations: config)
  let context = container.mainContext
  for attempt in ExampleAttempts {
    context.insert(attempt)
  }
  
  return HistoryGraphView()
    .modelContainer(container)
}
