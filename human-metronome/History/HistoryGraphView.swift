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
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Accuracy Over Time")
                        .font(.title3)
                        .bold()
                    Chart {
                        ForEach(attempts, id: \.self) {
                            attempt in
                            LineMark(
                                x: .value("Date", attempt.date),
                                y: .value("Accuracy", (1 - attempt.errorPercent) * 100)
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
                    Text("Accuracy and BPM")
                        .font(.title3)
                        .bold()
                    Chart {
                        ForEach(attempts, id: \.self) {
                            attempt in
                            PointMark(
                                x: .value("BPM", attempt.bpm),
                                y: .value("Accuracy", (1 - attempt.errorPercent) * 100)
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
                    Text("Game Length and Accuracy")
                        .font(.title3)
                        .bold()
                    Chart {
                        ForEach(attempts, id: \.self) {
                            attempt in
                            PointMark(x: .value("Game Length", attempt.attemptLength), y: .value("Accuracy", (1 - attempt.errorPercent) * 100))
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
