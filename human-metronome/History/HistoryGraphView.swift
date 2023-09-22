//
//  HistoryGraphView.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//

import SwiftUI
import Charts

struct HistoryGraphView: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(key: #keyPath(Attempt.date), ascending: true)
        ]) private var attempts: FetchedResults<Attempt>
    
    private func getNonManagedAttempts() -> [NonManagedAttempt] {
        var nonManagedAttempts: [NonManagedAttempt] = []
        
        for attempt in attempts {
            nonManagedAttempts.append(NonManagedAttempt(
                bpm: attempt.bpm,
                date: attempt.date,
                errorPercent: attempt.errorPercent,
                attemptLength: attempt.attemptLength
            ))
        }
        
        return nonManagedAttempts
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                InitialStatsView(attempts: getNonManagedAttempts())
                VStack(alignment: .leading) {
                    Text("Precision Over Time")
                        .font(.title3)
                        .bold()
                    Chart {
                        ForEach(getNonManagedAttempts(), id: \.self) {
                            attempt in
                            LineMark(
                                x: .value("Date", attempt.date),
                                y: .value("Precision", (1 - attempt.errorPercent) * 100)
                            ).symbol(.circle)
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .chartYScale(domain: .automatic(includesZero: false))
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
                    Chart {
                        ForEach(getNonManagedAttempts(), id: \.self) {
                            attempt in
                            PointMark(
                                x: .value("BPM", attempt.bpm),
                                y: .value("Precision", (1 - attempt.errorPercent) * 100)
                            ).symbol(.circle)
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .chartYScale(domain: .automatic(includesZero: false))
                    .chartYAxis {
                        AxisMarks(
                            format: Decimal.FormatStyle.Percent.percent.scale(1)
                        )
                    }
                }
                
                VStack (alignment: .leading) {
                    Text("Game Length and Precision")
                        .font(.title3)
                        .bold()
                    Chart {
                        ForEach(getNonManagedAttempts(), id: \.self) {
                            attempt in
                            PointMark(x: .value("Game Length", attempt.attemptLength), y: .value("Precision", (1 - attempt.errorPercent) * 100))
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .chartYScale(domain: .automatic(includesZero: false))
                    .chartYAxis {
                        AxisMarks(
                            format: Decimal.FormatStyle.Percent.percent.scale(1)
                        )
                    }
                }

            }
        }.padding()
    }
}
