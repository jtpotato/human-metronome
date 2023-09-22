//
//  InitialStatsView.swift
//  human-metronome
//
//  Created by Joel Tan on 22/9/2023.
//

import SwiftUI

struct InitialStatsView: View {
    var attempts: [NonManagedAttempt]
    
    func sortAttempts(sortType: String) -> [NonManagedAttempt] {
        return attempts.sorted {
            (lhs: NonManagedAttempt, rhs: NonManagedAttempt) in
            if (sortType == "bpm") {
                return lhs.bpm > rhs.bpm
            }
            else {
                return lhs.date < rhs.date
            }
        }
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

func getDummyData() -> [NonManagedAttempt] {
    var attempts: [NonManagedAttempt] = []
    
    for _ in 0...15 {
        attempts.append(
            NonManagedAttempt(
                bpm: Double.random(in: 60...320),
                date: Date.now.addingTimeInterval(Double.random(in:-1000000...0)),
            errorPercent: Double.random(in: 0...10),
            attemptLength: 8)
        )
    }
    
    return attempts
}

#Preview {
    InitialStatsView(attempts: getDummyData())
}
