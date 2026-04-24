//
//  PredatorDetails.swift
//  JP Apex Predators
//
//  Created by Hadeer Ibrahim on 15/04/2026.
//

import SwiftUI
import MapKit

struct PredatorDetails: View {
    let predator : ApexPredator
    
    @State var position : MapCameraPosition
    @Namespace var nameSpace
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment:.bottomTrailing){
                    // background type
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.88),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: UnitPoint.top, endPoint: .bottom)
                        }
                    
                    // predator image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x : -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                VStack(alignment: .leading){
                    // Predator Name
                    Text(predator.name)
                        .font(.largeTitle)
                        .padding(.vertical, 4)
                    
                    // Map View
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(
                            centerCoordinate: predator.location,
                            distance: 1000,
                            heading: 250,
                            pitch: 80
                        )))
                        .navigationTransition(.zoom(
                            sourceID: 1, in: nameSpace
                        ))
                    }
                    label:{
                        Map(position: $position){
                            // annotation
                            Annotation(predator.name, coordinate: predator.location){
                                // PIN
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .font(.largeTitle)
                                .padding(.trailing)
                        }
                        .overlay(alignment:.topLeading){
                            Text("Current Location")
                                .padding(5)
                                .background(.black.opacity(0.4))
                                .clipShape(.rect(bottomTrailingRadius:15))
                        }
                        .clipShape(.rect(topLeadingRadius: 15))
                    }
                    .matchedTransitionSource(id: 1, in: nameSpace)
                    // Appears In Text
                    Text("Appears in:")
                        .bold()
                        .padding(.top)
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    // Movies Moment Text
                    Text("Movie Moments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    // Movie Moment Name Text
                    ForEach(predator.movieScenes){ scene in
                        VStack(alignment:.leading){
                            Text(scene.movie)
                                .font(.title2)
                                .padding(.vertical, 2)
                            Text(scene.sceneDescription)
                                .padding(.bottom, 15)
                        }
                    }
                    
                    // Movie Moment Scene
                    Text("Read more: ")
                        .font(.caption)
                    // Link
                    Link(predator.link, destination: URL(string:predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let predator = Predators().apexPredators[2]
    NavigationStack{
        PredatorDetails(
            predator:predator,
            position: .camera(MapCamera(
                centerCoordinate: predator.location,
                distance: 30000
            )))
        .preferredColorScheme(.dark)
    }
}
