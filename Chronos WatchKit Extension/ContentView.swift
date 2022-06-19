//
//  ContentView.swift
//  Chronos WatchKit Extension
//
//  Created by Alessandro Alberti on 19/06/22.
//

import SwiftUI

struct ContentView: View {
    var counters: [Counter]
    
    var body: some View {
        List {
            //MARK: Counters
            ForEach(counters) { counter in
                CounterCardView(counter: counter)
                    .listRowInsets(EdgeInsets())
                    .cornerRadius(20)
            }
            //MARK: Add Button
            .toolbar{
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {}) {
                        Text("+ Add")
                            .font(Font.system(size: 30, weight: .semibold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .offset(x: -10)
                    }
                    .tint(Color(UIColor.darkGray))
                }
            }
            
            
        }.listStyle(CarouselListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(counters: [])
    }
}
