//
//  InitialStatsView.swift
//  human-metronome
//
//  Created by Joel Tan on 22/9/2023.
//

import SwiftUI
import SwiftData

struct SummaryStats: View {
  var attempts: [Attempt]
  
  var body: some View {
    Group {
      ScrollView() {
        VStack (alignment: .center, spacing: 40) {
          VStack {
            Text(String(attempts.count))
              .font(.title3)
              .bold()
            Text("Total Attempts")
          }
          VStack {
            Text(String(format: "%.0f", sortAttempts(sortType: "bpm")[0].bpm))
              .font(.title3)
              .bold()
            Text("Fastest BPM")
          }
          VStack {
            Text(sortAttempts(sortType: "date")[0].date, style: .date)
              .font(.title3)
              .bold()
              .lineLimit(1)
            Text("Playing since")
          }
        }.frame(maxWidth: .infinity)
      }
      
    }.padding()
  }
}

#Preview {
  SummaryStats(attempts: ExampleAttempts)
}
