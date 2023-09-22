//
//  NonManagedAttempt.swift
//  human-metronome
//
//  Created by Joel Tan on 22/9/2023.
//

import Foundation

struct NonManagedAttempt: Hashable {
    var bpm: Double
    var date: Date
    var errorPercent: Double
    var attemptLength: Double
}
