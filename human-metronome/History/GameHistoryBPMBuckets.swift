//
//  GameHistoryAnalysis.swift
//  human-metronome
//
//  Created by Joel Tan on 22/9/2023.
//

import Foundation
import SwiftUI
import Charts

func roundToNearest(value: Double, toNearest: Double) -> Int {
    // Should really be round down to nearest :)
    return Int(floor(value * (1 / toNearest)) * toNearest)
}

struct Bucket: Hashable {
    var label: String
    var value: Double
}

func bpmToBuckets(attempts: FetchedResults<Attempt>) -> [Bucket] {
    var bpmBuckets: [Int: Int] = [:]
    
    for attempt in attempts {
        let bucket = roundToNearest(value: attempt.bpm, toNearest: 5)
        if (bpmBuckets[bucket] != nil) {
            bpmBuckets[bucket]! += 1
        }
        else {
            bpmBuckets[bucket] = 0
        }
    }
    
    var bpmBucketObjects: [Bucket] = Array()
    
    for (key, value) in bpmBuckets {
        bpmBucketObjects.append(Bucket(label: String(key), value: Double(value)))
    }
    
    return bpmBucketObjects
}

struct GameHistoryBPMBuckets: View {
    // dummy data
    var attempts: FetchedResults<Attempt>
    
    var body: some View {
        ForEach(bpmToBuckets(attempts: attempts), id: \.self) {
            bucket in
            Text("\(bucket.label) \(bucket.value)")
        }
    }
}
