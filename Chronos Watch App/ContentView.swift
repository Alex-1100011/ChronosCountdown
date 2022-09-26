//
//  ContentView.swift
//  Chronos Watch App
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                //Counters
                ForEach(0 ..< 5) { _ in
                    CounterCardView(counter: Counter(days: 3), isSmall: true)
                        .listRowInsets(EdgeInsets())
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                //Add Button
                
                .toolbar{
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {}) {
                            Text("+ Add")
                                .font(Font.system(size: 30, weight: .medium, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .offset(x: -10)
                        }
                        .tint(Color(UIColor.darkGray))
                    }
                }
            }
            .listStyle(CarouselListStyle())
//            .navigationTitle("Chronos")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
