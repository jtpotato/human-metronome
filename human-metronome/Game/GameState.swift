//
//  GameState.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import Foundation
import SwiftUI

class GameState: ObservableObject {
    @Published var tapCounter = 0
    @Published var path = NavigationPath()
    @Published var tapTimes: [UInt64] = []
    @Published var selectedGameLength: Int = 8
}
