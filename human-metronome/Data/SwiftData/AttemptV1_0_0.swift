//
//  Attempt.swift
//  human-metronome
//
//  Created by Joel Tan on 17/2/2024.
//
//

import Foundation
import SwiftData

enum AttemptSchemaV1: VersionedSchema {
  static var versionIdentifier = Schema.Version(1, 0, 0)
  
  static var models: [any PersistentModel.Type] {
      [Attempt.self]
  }
  
  @Model
  class Attempt {
    var attemptLength: Int
    var bpm: Double
    var date: Date
    var errorPercent: Double
    
    init(attemptLength: Int, bpm: Double, date: Date, errorPercent: Double) {
      self.attemptLength = attemptLength
      self.bpm = bpm
      self.date = date
      self.errorPercent = errorPercent
    }
  }
}
