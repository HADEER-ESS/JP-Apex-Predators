//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Hadeer Ibrahim on 14/04/2026.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchValue : String = ""
    @State var alphabitical = false
    @State var currentSelection = APType.all
    
    var filteredData : [ApexPredator]{
        predators.filter(by: currentSelection)
        
        predators.sort(by: alphabitical)
        
        return predators.search(for: searchValue)
    }
    var body: some View {
        NavigationStack{
            List(filteredData){ predator in
                NavigationLink{
                    PredatorDetails(predator: predator)
                }label: {
                    HStack{
                        // Predator Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading){
                            // Predator Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            //Predator Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchValue)
            .autocorrectionDisabled()
            .animation(.default, value: searchValue)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        withAnimation{
                            alphabitical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabitical ? "film" : "textformat").symbolEffect(.rotate, value: alphabitical)
                    }
                }
                ToolbarItem(placement:.topBarTrailing){
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(APType.allCases){
                                type in
                                Label(type.rawValue.capitalized,systemImage:type.typeIcon)
                            }
                        }
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
