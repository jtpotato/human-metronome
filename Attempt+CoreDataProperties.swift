//
//  Attempt+CoreDataProperties.swift
//  human-metronome
//
//  Created by Joel Tan on 20/9/2023.
//
//

import Foundation
import CoreData


extension Attempt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attempt> {
        return NSFetchRequest<Attempt>(entityName: "Attempt")
    }

    @NSManaged public var date: Date?
    @NSManaged public var bpm: Double
    @NSManaged public var errorPercent: Double

}

extension Attempt : Identifiable {

}
