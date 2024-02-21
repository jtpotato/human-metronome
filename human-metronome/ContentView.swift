//
//  ContentView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  var body: some View {
    TabView {
      GameView()
        .tabItem {
          Label("Game", systemImage: "gamecontroller.fill")
        }
      HistoryGraphView()
        .tabItem {
          Label("History", systemImage: "chart.xyaxis.line")
        }
    }
    .preferredColorScheme(.dark)
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(for: Attempt.self, configurations: config)
  
  return ContentView()
    .modelContainer(container)
}
