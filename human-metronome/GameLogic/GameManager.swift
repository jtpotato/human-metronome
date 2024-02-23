//
//  GameState.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import SwiftUI
import SwiftData
import Observation

@Observable
class GameManager {
  var tapCounter = 0
  var tapTimes: [UInt64] = []
  var selectedGameLength: Int = 8
  var gameInProgress = false
  private var hapticFeedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
  
  func startHaptics() {
    hapticFeedbackGenerator.prepare()
  }
  
  func tap(modelContext: ModelContext, onGameEnd: (GameDataAnalysis) -> Void) {
    gameInProgress = true
    
    tapTimes.append(DispatchTime.now().uptimeNanoseconds)
    tapCounter += 1
    
    // haptics
    hapticFeedbackGenerator.impactOccurred()
    
    // check if game should end
    if (tapTimes.count >= selectedGameLength) {
      let analysis = gameEndTasks(modelContext)
      onGameEnd(analysis)
    }
  }
  
  private func gameEndTasks(_ context: ModelContext) -> GameDataAnalysis {    
    // Analytics
    let analysis = GameDataAnalysis(rawTapTimes: tapTimes)
    let newAttempt = Attempt(attemptLength: selectedGameLength, bpm: analysis.getBPM(), date: Date.now, errorPercent: analysis.getAverageErrorPercent())
    context.insert(newAttempt) // save to SwiftData
    
    // Reset all
    tapCounter = 0
    tapTimes = []
    gameInProgress = false
    
    return analysis
  }
}
