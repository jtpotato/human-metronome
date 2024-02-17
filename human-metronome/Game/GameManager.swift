//
//  GameState.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import SwiftUI
import Observation

@Observable
class GameManager {
  var tapCounter = 0
  var tapTimes: [UInt64] = []
  var selectedGameLength: Int = 8
  
  func tap(onGameEnd: () -> Void) {
    tapTimes.append(DispatchTime.now().uptimeNanoseconds)
    tapCounter += 1
    
    // check if game should end
    if (tapTimes.count >= selectedGameLength) {
      gameEndTasks()
      onGameEnd()
    }
  }
  
  private func gameEndTasks() {
    // Haptics
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    
    // Analytics
    let analysis = GameDataAnalysis(rawTapTimes: tapTimes)
    let newAttempt = Attempt(attemptLength: selectedGameLength, bpm: analysis.getBPM(), date: Date.now, errorPercent: analysis.getAverageErrorPercent())
  }
}
