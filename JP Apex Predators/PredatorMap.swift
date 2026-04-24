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
    @State var showNote = false
    
    var body: some View {
        Map(position: $position){
            ForEach(predators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Button{
                        showNote.toggle()
                    }label: {
                        if showNote{
                            VStack(alignment: .leading){
                                Text("Name :\(predator.name)")
                                .font(.body)
                                Text("Type :\(predator.type.rawValue)")
                                    .font(.caption)
                                Divider()
                                    .background(.white)
                                Text("Movies :")
                                    .font(.headline)
                                ForEach(predator.movies, id: \.self) { movie in
                                    Text("•" + movie)
                                        .font(.caption)
                                }
                            }
                            .padding(9)
                            .background(.brown.opacity(0.4))
                            .clipShape(.rect(cornerRadius: 15))
                        }
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .shadow(color: .white, radius: 2)
                            .scaleEffect(x: -1)
                    }
                }
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
