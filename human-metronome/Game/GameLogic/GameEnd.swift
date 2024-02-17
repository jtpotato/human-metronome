//
//  GameEnd.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import Foundation
import SwiftUI
import CoreData

func save(gameState: GameState, viewContext: NSManagedObjectContext) {
    // Analysis
    let analysis = GameDataAnalysis(rawTapTimes: gameState.tapTimes)
    
    // Add to coredata
    let newAttempt = Attempt(context: viewContext)
    newAttempt.date = Date.now
    newAttempt.bpm = analysis.getBPM()
    newAttempt.errorPercent = analysis.getAverageErrorPercent()
    newAttempt.attemptLength = gameState.selectedGameLength
    
    try? viewContext.save()
}



func onGameEnd(gameState: GameState, viewContext: NSManagedObjectContext) {
    if (gameState.tapCounter != gameState.selectedGameLength) {
        return
    };
    
    if (gameState.tapTimes.count > Int(gameState.selectedGameLength)) {
        gameState.tapTimes.removeFirst(gameState.tapTimes.count - Int(gameState.selectedGameLength))
    }
    
    gameState.tapCounter = 0
    
    print(gameState.tapTimes)
    
    // Haptics
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    
    if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1") {
        print("Is in preview mode, do not attempt to save to CoreData")
    }
    else {
        save(gameState: gameState, viewContext: viewContext)
    }
    
    gameState.path.append("view-results")
}
