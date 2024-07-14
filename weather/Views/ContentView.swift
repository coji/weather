//
//  ContentView.swift
//  weather
//
//  Created by coji on 2024/07/14.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SpriteKit

struct ContentView: View {
  @Binding
  private(set) var weather: Weather
  private let weatherForecasts: [WeatherForecast] = [WeatherForecast(time: "2024-07-14 10:00", temperature: "20°", weather: .rain)]

  var body: some View {
    VStack {
      Model3D(named: "Scene", bundle: realityKitContentBundle)
        .padding(.bottom, 50)

      Text("Hello, world!")
    }
    .padding()
  }

  private func weatherInformation() -> some View {
    HStack {
      VStack {
        Text("7月14日(日)")
          .font(.system(size: 60))
      }
      .padding()

      VStack {
        Text("現在地")
        Text("10°")
        HStack {
          Text("最\n高")
          Text("34°")
          Text("最\n低")
          Text("22°")
        }
        .font(.system(size: 25))
        Text(weather.rawValue)
          .font(.system(size: 25))
      }
      .padding()
    }
    .shadow(radius: 5)
    .font(.system(size: 50))
    .bold()
  }

  private func forecastScrollView() -> some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(weatherForecasts, id: \.id) { weatherForecast in
          Button(action: {
            weather = weatherForecast.weather
          }, label: {
            weatherCell(weatherForecast: weatherForecast)
          })
          .padding()
        }
      }
    }
  }

  private func weatherCell(weatherForecast: WeatherForecast) -> some View {
    VStack {
      Text(weatherForecast.time)
        .font(.system(size: 25))

      Model3D(named: modelFileName(for: weatherForecast.weather)) { model in
        model
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 250, height: 50)
          .padding()
      } placeholder: {
        ProgressView()
      }

      Text(weatherForecast.temperature)
        .font(.system(size: 25))
    }
    .shadow(radius: 5)
    .bold()
    .frame(width: 200, height: 200)
  }

  private func modelFileName(for weather: Weather) -> String {
    return weather == .sunny ? "Sun" : weather == .rain ? "Rain" : "Snow"
  }

  private func weatherParticle(size: CGSize, weather: Weather) -> SKScene? {
    guard weather != .sunny else { return nil }

    let fileName: String = weather == .rain ? "RainParticle" : "SnowParticle"
    let backgroundNode = SKSpriteNode(imageNamed: weather.rawValue)
    backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    let emitterNode = SKEmitterNode(fileNamed: fileName)!
    let scene = SKScene(size: size)
    scene.addChild(backgroundNode)
    scene.addChild(emitterNode)
    scene.anchorPoint = .init(x: 0.5, y: 1)
    return scene
  }
}


#Preview(windowStyle: .automatic) {
  ContentView(weather: .constant(.sunny))
}
