//
//  ResultsView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI
import Charts

struct GameResultView: View {
    @Binding var tapTimes: [Double]
    
    func getAverage() -> Double {
        let totalTime = tapTimes.last! - tapTimes.first!
        
        return totalTime / Double(tapTimes.count - 1)
    }
    
    func getTimeTapDeltas() -> [TapEvent] {
        var timeTapDeltas: [TapEvent] = []
        var i = 1
        while (i < tapTimes.count) {
            let tapDelta = tapTimes[i] - tapTimes[i - 1]
            let tapError = getAverage() - tapDelta
            let tapErrorPercent = abs(tapError) / tapDelta
            timeTapDeltas.append(TapEvent(
                tapIndex: i,
                tapDelta: tapDelta,
                tapError: tapError,
                tapErrorPercent: tapErrorPercent
            ))
            
            i += 1
        }
        
        return timeTapDeltas
    }
    
    func getAverageErrorPercent() -> Double {
        let tapEvents = getTimeTapDeltas()
        
        var errorPercentSum: Double = 0
        
        for tapEvent in tapEvents {
            errorPercentSum += tapEvent.tapErrorPercent
        }
        
        print(errorPercentSum)
        print(Double(tapEvents.count))
        print(errorPercentSum / Double(tapEvents.count))
        
        return errorPercentSum / Double(tapEvents.count)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                VStack(spacing: 20) {
                    HStack {
                        Text("Estimated BPM")
                        Spacer()
                        Text("\(60 / getAverage())")
                            .monospaced()
                            .foregroundStyle(.gray)
                    }
                    HStack {
                        Text("Average Error")
                        Spacer()
                        Text("\(getAverageErrorPercent() * 100)%")
                            .monospaced()
                            .foregroundStyle(.gray)
                    }
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
                    Text("Red dotted line represents average.")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    Chart {
                        ForEach(getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Delta Time", $0.tapDelta)
                            ).symbol(.circle)
                        }
                        RuleMark(y: .value("Average", getAverage()))
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
                    Text("How early your hits were.")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                    Chart {
                        ForEach(getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Error", $0.tapError)
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
                        ForEach(getTimeTapDeltas()) {
                            LineMark(
                                x: .value("Tap No.", $0.tapIndex),
                                y: .value("Error", $0.tapErrorPercent * 100)
                            ).symbol(.circle)
                        }
                        RuleMark(y: .value("Error", getAverageErrorPercent() * 100))
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

struct GameResultPreviewView: View {
    // Fill with dummy data.
    @State var tapTimes = [427625.64031666674, 427625.80227683345, 427625.97286316677, 427626.1523317084, 427626.3315825001, 427626.5190010418, 427626.69617254176, 427626.8730185001]
    
    var body: some View {
        GameResultView(tapTimes: $tapTimes)
    }
    
}

#Preview {
    GameResultPreviewView()
}
