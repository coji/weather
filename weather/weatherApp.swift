//
//  weatherApp.swift
//  weather
//
//  Created by coji on 2024/07/14.
//

import SwiftUI

@main
struct weatherApp: App {
  @State var weatherName: Weather = .snow
  @Environment(\.openImmersiveSpace) var openImmersiveSpace
  @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

  var body: some Scene {
    WindowGroup {
      ContentView(weather: $weatherName)
        .task {
          await openImmersiveSpace(id: "ImmersiveSpace")
        }
        .onChange(of: weatherName) { _, newValue in
            Task {
                await dismissImmersiveSpace()
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
        }
    }
    .defaultSize(width: 1.5, height: 0.5, depth: 0, in: .meters)

    ImmersiveSpace(id: "ImmersiveSpace") {
      ImmersiveView(weatherName: $weatherName)
    }
    .immersionStyle(selection: .constant(.full), in: .full)
  }
}
