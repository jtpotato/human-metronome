//
//  ResultsView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI
import Charts

struct GameResultView: View {
    @Environment(\.displayScale) var displayScale
    
    var analysis: GameDataAnalysis
    
    @MainActor func shareResult() -> Image {
        let bpm = analysis.getBPM()
        let accuracyPercent = 1 - analysis.getAverageErrorPercent()
        
        let renderer = ImageRenderer(
            content: ShareGraphic(accuracyPercent: accuracyPercent, bpm: bpm)
        )
        
        renderer.scale = displayScale
        
        return Image(uiImage: renderer.uiImage!)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                VStack(alignment: .leading, spacing: 22) {
                    HStack {
                        Text("Estimated BPM")
                        Spacer()
                        Text("\(analysis.getBPM())")
                            .monospaced()
                            .foregroundStyle(.gray)
                    }
                    HStack {
                        Text("Accuracy")
                        Spacer()
                        Text("\((1 - analysis.getAverageErrorPercent()) * 100)%")
                            .monospaced()
                            .foregroundStyle(.gray)
                    }
                    ShareLink(item: shareResult(), preview: SharePreview("Result", image: shareResult()))
                }
                .padding(15.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            Color(
                                UIColor.secondarySystemBackground
                            )
                        )
                )
                
                
                VStack(alignment: .leading) {
                    Text("Time Between Clicks")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("(Miliseconds) Measured to nanosecond accuracy. Red dotted line represents average.")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Chart {
                        ForEach(analysis.getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Delta Time", $0.tapDelta / 1000000)
                            ).symbol(.circle)
                        }
                        RuleMark(y: .value("Average", analysis.getAverage()/1000000))
                            .lineStyle(StrokeStyle(dash: [8, 5]))
                            .foregroundStyle(.red)
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .chartYScale(domain: .automatic(includesZero: false))
                }
                
                
                VStack(alignment: .leading) {
                    Text("Error")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("(Miliseconds) Measured to nanosecond accuracy. How early your hits were.")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    Chart {
                        ForEach(analysis.getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Error", $0.tapError / 1000000)
                            ).symbol(.circle)
                        }
                    }.aspectRatio(1.5, contentMode: .fit)
                }
                
                VStack(alignment: .leading) {
                    Text("Error %")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Red dotted line represents average.")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Chart {
                        ForEach(analysis.getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Error", $0.tapErrorPercent * 100)
                            ).symbol(.circle)
                        }
                        RuleMark(y: .value("Error", analysis.getAverageErrorPercent() * 100))
                            .lineStyle(StrokeStyle(dash: [8, 5]))
                            .foregroundStyle(.red)
                    }.aspectRatio(1.5, contentMode: .fit)
                        .chartYAxis {
                            AxisMarks(
                                format: Decimal.FormatStyle.Percent.percent.scale(1)
                            )
                        }
                }
                
            }
            .padding()
            .navigationTitle("Your Results")
        }
        
    }
}

#Preview {
    GameResultView()
}
