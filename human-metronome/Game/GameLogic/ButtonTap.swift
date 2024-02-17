//
//  ButtonTap.swift
//  human-metronome
//
//  Created by Joel Tan on 30/9/2023.
//

import Foundation
import SwiftUI

func onButtonTap(_ gameState: GameState) {
    gameState.tapTimes.append(DispatchTime.now().uptimeNanoseconds)
    gameState.tapCounter += 1
}
