//
//  GameView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI

struct GameView: View {
    private var gameLengths: [Double] = [8, 12, 16]
    
    @State var tapCounter = 0
    @State var path = NavigationPath()
    @State var tapTimes: [UInt64] = []
    @State var selectedGameLength: Double = 8
    
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
        newAttempt.attemptLength = selectedGameLength
        
        try? viewContext.save()
    }
    
    func onGameEnd() {
        if (tapTimes.count > Int(selectedGameLength)) {
            tapTimes.removeFirst(tapTimes.count - Int(selectedGameLength))
        }
        tapCounter = 0
        
        print(tapTimes)
        
        // Haptics
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // This is the code that doesnt work
        // saveData()
        
        // This is the code that works
        
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
                    
                    if (tapCounter == Int(selectedGameLength)) {
                        onGameEnd()
                    }
                }) {
                    Circle()
                        .frame(width: 120, height: 120)
                }
                Text("Tap \(Int(selectedGameLength) - tapCounter) times.")
                Spacer()
                VStack (alignment: .leading) {
                    Text("Attempt Length")
                    Picker("Attempt Length", selection: $selectedGameLength) {
                        ForEach(gameLengths, id: \.self) {
                            gameLength in
                            Text("\(String(format: "%.0f", gameLength))")
                        }
                    }.pickerStyle(.segmented)
                    .disabled(true)
                    Text("(Paid) feature coming soon.")
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
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
