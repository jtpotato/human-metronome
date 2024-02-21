//
//  AnalyseGameData.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//

import Foundation

struct GameDataAnalysis: Hashable {
  var rawTapTimes: [UInt64]
  
  func tapTimes() -> [Double] {
    return rawTapTimes.map { Double($0) }
  }
  
  func getAverage() -> Double {
    let totalTime = tapTimes().last! - tapTimes().first!
    
    // This is average delta in *nanoseconds*
    return totalTime / Double(tapTimes().count - 1)
  }
  
  func getBPM() -> Double {
    // thats one minute (in nanoseconds)
    return 60 * 1000000000 / getAverage()
  }
  
  func getTimeTapDeltas() -> [TapEvent] {
    var timeTapDeltas: [TapEvent] = []
    var i = 1
    while (i < tapTimes().count) {
      let tapDelta = tapTimes()[i] - tapTimes()[i - 1]
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
    
    return errorPercentSum / Double(tapEvents.count)
  }
}

