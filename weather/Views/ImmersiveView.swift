//
//  ImmersiveView.swift
//  weather
//
//  Created by coji on 2024/07/14.
//

import Combine
import SwiftUI
import RealityKit

struct ImmersiveView: View {
  @Binding private(set) var weatherName: Weather
  @State var cancellable: AnyCancellable?

  var body: some View {
    RealityView { content in
      let entity = Entity()
      cancellable = TextureResource.loadAsync(named: weatherName.rawValue).sink { error in
        print(error)
      } receiveValue: { resource in
        var material = UnlitMaterial()
        material.color = .init(texture: .init(resource))
        entity.components.set(ModelComponent(
          mesh: .generateSphere(radius: 1000),
          materials: [material]
        ))
        entity.scale *= .init(x: -1, y: 1, z: 1)
      }
      content.add(entity)
    }
  }
}

#Preview {
  ImmersiveView(weatherName: .constant(.sunny))
}
