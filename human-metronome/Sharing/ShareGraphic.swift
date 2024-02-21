//
//  ShareGraphic.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//

import SwiftUI

struct ShareGraphic: View {
  var accuracyPercent: Double
  var bpm: Double
  var body: some View {
    VStack {
      VStack(spacing: 20.0) {
        Text("Human Metronome")
        VStack {
          Text("Accuracy")
            .font(.title3)
          Text("\(String(format: "%.0f", accuracyPercent * 100))%")
            .font(.largeTitle)
            .bold()
        }
        Text("@ \(String(format: "%.0f", bpm)) BPM")
        Text("Can you beat this?")
      }
      .foregroundStyle(.white)
      .background(
        ZStack {
          Rectangle()
          Circle()
            .fill(
              RadialGradient(
                colors: [.yellow, .clear],
                center: .center,
                startRadius: 0,
                endRadius: 250
              )
            )
            .opacity(0.3)
            .frame(
              width: 500,
              height: 500
            )
        }
      )
    }
    .frame(width: 500.0, height: 500.0)
    
  }
}

#Preview {
  ShareGraphic(accuracyPercent: 0.98, bpm: 120.0)
}
