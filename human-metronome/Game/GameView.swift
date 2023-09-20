//
//  GameView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI

struct GameView: View {
    @State var tapCounter = 0
    @State var path = NavigationPath()
    @State var tapTimes: [UInt64] = []
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    
    func saveData() {
        // Analysis
        let analysis = GameDataAnalysis(rawTapTimes: tapTimes)
        
        // Add to coredata
        let newAttempt = Attempt(context: viewContext)
        newAttempt.date = Date.now
        newAttempt.bpm = analysis.getBPM()
        newAttempt.errorPercent = analysis.getAverageErrorPercent()
        
        try? viewContext.save()
    }
    
    func onGameEnd() {
        if (tapTimes.count > 8) {
            tapTimes.removeFirst(tapTimes.count - 8)
        }
        tapCounter = 0
        
        print(tapTimes)
        
#if DEBUG
        if (ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1") {
            print("Is in preview mode, do not attempt to save to CoreData")
        }
        else {
            saveData()
        }
#else
        saveData()
#endif
        
        path.append("view-results")
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 40.0) {
                Spacer()
                Button(action: {
                    tapTimes.append( DispatchTime.now().uptimeNanoseconds)
                    tapCounter += 1
                    
                    if (tapCounter == 8) {
                        onGameEnd()
                    }
                }) {
                    Circle()
                        .frame(width: 120, height: 120)
                }
                Text("Tap \(8 - tapCounter) times.")
                Spacer()
            }
            .navigationDestination(for: String.self) {
                destination in
                
                if (destination == "view-results") {
                    GameResultView(analysis: GameDataAnalysis(rawTapTimes: tapTimes))
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameView()
}
