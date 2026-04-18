//
//  PredatorDetails.swift
//  JP Apex Predators
//
//  Created by Hadeer Ibrahim on 15/04/2026.
//

import SwiftUI

struct PredatorDetails: View {
    let predator : ApexPredator
    
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
                    
                    // Appears In Text
                    Text("Appears in:")
                        .bold()
                        .padding(.bottom, 2)
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
    PredatorDetails(predator: Predators().apexPredators[10])
        .preferredColorScheme(.dark)
}
