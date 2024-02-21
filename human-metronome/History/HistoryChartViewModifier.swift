//
//  HistoryChartViewModifier.swift
//  human-metronome
//
//  Created by Joel Tan on 21/2/2024.
//

import Charts
import SwiftUI

struct HistoryChartViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .aspectRatio(1.5, contentMode: .fit)
      .chartScrollableAxes(.horizontal)
      .chartYScale(domain: .automatic(includesZero: false))
  }
}

extension Chart {
  func historyChartView() -> some View {
    modifier(HistoryChartViewModifier())
  }
}
