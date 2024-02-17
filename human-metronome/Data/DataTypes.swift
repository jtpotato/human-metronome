//
//  DataTypes.swift
//  human-metronome
//
//  Created by Joel Tan on 19/9/2023.
//

import Foundation

struct TapEvent: Identifiable {
  var id = UUID()
  var tapIndex: Int
  var tapDelta: Double
  var tapError: Double
  var tapErrorPercent: Double
}
