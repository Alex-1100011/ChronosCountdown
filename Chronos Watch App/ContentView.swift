//
//  ContentView.swift
//  Chronos Watch App
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List{
            //Counters
            ForEach(testCounters) { counter in
                CounterCardView(counter: counter)
                    .listRowInsets(EdgeInsets())
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            //Add Button
            
            .toolbar{
                
                Button(action: {}) {
                    Text("+ Add")
                        .font(Font.system(size: 30, weight: .medium, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .offset(x: -10)
                }
                .padding(.bottom)
            }
        }
        .listStyle(CarouselListStyle())
                    .navigationTitle("Chronos")
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
