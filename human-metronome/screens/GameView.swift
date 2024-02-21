//
//  GameUI.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import SwiftUI
import SwiftData

struct GameView: View {
  @Environment(\.modelContext) private var context
  
  @State private var path = NavigationPath()
  @State private var currentGame = GameManager()
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack(spacing: 40.0) {
        Spacer()
        Text("Tap with a consistent beat.")
          .multilineTextAlignment(.center)
        Button(action: {
          currentGame.tap(modelContext: context) { analysis in
            // on game end handler. should make it more clear.
            path.append(analysis)
            print("navigating")
          }
        }) {
          Circle()
            .frame(width: 160, height: 200)
        }
        
        Text("Tap \(currentGame.selectedGameLength - currentGame.tapCounter) times.")
        Spacer()
        
        VStack (alignment: .leading) {
          Text("Attempt Length")
          Picker("Attempt Length", selection: $currentGame.selectedGameLength) {
            ForEach(gameLengths, id: \.self) {
              gameLength in
              Text("\(gameLength)")
            }
          }.pickerStyle(.segmented)
        }
      }
      .padding()
      .navigationDestination(for: GameDataAnalysis.self) { analysis in
        GameResultView(analysis: analysis)
      }
    }
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Attempt.self, configurations: config)
  
  return GameView()
    .modelContainer(container)
}
