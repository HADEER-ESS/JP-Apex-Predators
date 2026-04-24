//
//  PredatorMap.swift
//  JP Apex Predators
//
//  Created by Hadeer Ibrahim on 23/04/2026.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators().apexPredators
    
    @State var position : MapCameraPosition
    @State var satalite  = false
    
    var body: some View {
        Map(position: $position){
            ForEach(predators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .shadow(color: .white, radius: 2)
                        .scaleEffect(x: -1)
                }
                .annotationTitles(.hidden)
            }
        }
        .mapStyle( satalite ?
            .imagery(elevation: .realistic) :
                .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing){
            Button{
                satalite.toggle()
            }label: {
                Image(systemName: satalite ? "globe.americas.fill" : "globe.americas")
                    .font(.title)
                    .imageScale(.large)
                    .padding(4)
            }
        }
    }
}

#Preview {
    let predator_location = Predators().apexPredators[2].location
    PredatorMap(position: .camera(MapCamera(
        centerCoordinate: predator_location,
        distance: 1000,
        heading: 250,
        pitch: 80
    )))
    .preferredColorScheme(.dark)
}
