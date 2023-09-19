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
    @State var tapTimes: [CFTimeInterval] = []
    
    func onGameEnd() {
        if (tapTimes.count > 8) {
            tapTimes.removeFirst(tapTimes.count - 8)
        }
        tapCounter = 0
        path.append("view-results")
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 40.0) {
                Spacer()
                Button(action: {
                    tapTimes.append(CACurrentMediaTime())
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
                Button(action: {}) {
                    Text("About")
                }
            }
            .navigationDestination(for: String.self) {
                destination in
                
                if (destination == "view-results") {
                    GameResultView(tapTimes: $tapTimes)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameView()
}
