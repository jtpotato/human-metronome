//
//  ContentView.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameView()
                .preferredColorScheme(.dark)
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }
            HistoryGraphView()
                .tabItem {
                    Label("History", systemImage: "chart.xyaxis.line")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
