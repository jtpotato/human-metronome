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
  
  func oldestDate() -> Date? {
    return attempts.min { a, b in a.date < b.date }?.date
  }
  
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
            Text(String(format: "%.0f", (
              attempts.max { a, b in a.bpm < b.bpm }
            )?.bpm ?? "-"))
            .font(.title3)
            .bold()
            Text("Fastest BPM")
          }
          VStack {
            if oldestDate() != nil {
              Text(oldestDate()!, style: .date)
                .font(.title3)
                .bold()
                .lineLimit(1)
              Text("Playing since")
            }
          }
        }.frame(maxWidth: .infinity)
      }
    }.padding()
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Attempt.self, configurations: config)

  return SummaryStats(attempts: ExampleAttempts)
    .modelContainer(container)
}
