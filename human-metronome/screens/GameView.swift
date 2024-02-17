//
//  GameUI.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import SwiftUI

struct GameView: View {
  var body: some View {
    NavigationStack {
      VStack(spacing: 40.0) {
        Spacer()
        Text("Tap with a consistent beat.")
          .multilineTextAlignment(.center)
        Button(action: {
          onButtonTap(gameState)
          onGameEnd(gameState: gameState, viewContext: viewContext)
        }) {
          Circle()
            .frame(width: 240, height: 240)
        }
        Text("Tap \(Int(gameState.selectedGameLength) - gameState.tapCounter) times.")
        Spacer()
        VStack (alignment: .leading) {
          Text("Attempt Length")
          Picker("Attempt Length", selection: $gameState.selectedGameLength) {
            ForEach(gameLengths, id: \.self) {
              gameLength in
              Text("\(String(gameLength))")
            }
          }.pickerStyle(.segmented)
        }
      }
      .padding()
    }
  }
}
