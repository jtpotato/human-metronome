//
//  Attempts.swift
//  human-metronome
//
//  Created by Joel Tan on 17/2/2024.
//

import Foundation

let ExampleAttempts = [
  Attempt(attemptLength: 8, bpm: 120, date: Date.now.addingTimeInterval(-1 * 60 * 60 * 24 * 7), errorPercent: 0.94),
  Attempt(attemptLength: 16, bpm: 140, date: Date.now.addingTimeInterval(-1 * 60 * 60 * 24 * 5), errorPercent: 0.68),
  Attempt(attemptLength: 32, bpm: 120, date: Date.now.addingTimeInterval(-1 * 60 * 60 * 24 * 4), errorPercent: 0.12),
  Attempt(attemptLength: 16, bpm: 130, date: Date.now.addingTimeInterval(-1 * 60 * 60 * 24 * 3), errorPercent: 0.99),
  Attempt(attemptLength: 8, bpm: 11, date: Date.now.addingTimeInterval(-1 * 60 * 60 * 24 * 2), errorPercent: 0.97),
  Attempt(attemptLength: 8, bpm: 142, date: Date.now, errorPercent: 0.99),
]
