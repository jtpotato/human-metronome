//
//  Attempt.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//

import Foundation
import CoreData

final class Attempt: NSManagedObject {
    @NSManaged var date: Date
    @NSManaged var bpm: Double
    @NSManaged var errorPercent: Double
    @NSManaged var attemptLength: Double
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "date")
        setPrimitiveValue(Double(120), forKey: "bpm")
        setPrimitiveValue(Double(5), forKey: "errorPercent")
        setPrimitiveValue(Double(8), forKey: "attemptLength")
    }
}
