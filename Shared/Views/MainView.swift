//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @EnvironmentObject var dataController: DataController
    ///This state controls the size of the ``CounterCardView``
    @State var isAspectSmall = true
    @State var showCreateView = false
    
    var body: some View {
        NavigationView {
           ScrollView {
               LazyVGrid(columns: [GridItem(.adaptive(minimum: isAspectSmall ? 180 : 360))],spacing: 25) {
                   
                    ForEach(dataController.counters){ counter in
                        //MARK: Counter
                        CounterCardView(counter: counter, isSmall: isAspectSmall)
                            .contextMenu{
                                Button(role: .destructive, action: {}){
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            .navigationBarTitle("Counters")
            //MARK: navigationBarItems
            .navigationBarItems(trailing:
             HStack {
                
                //MARK: Change size button
                Button{
                    withAnimation{
                        isAspectSmall.toggle()
                    }
                } label: {
                    Label("Change card size", systemImage: isAspectSmall ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                }
                
                //MARK: Add button
                Button{
                    showCreateView = true
                } label: {
                    Label("Add new counter", systemImage: "plus")
                }
            })
        }
        //To avoid side list on iPad
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showCreateView){
            CreateView(showSheet: $showCreateView)
            // datacontroller.add counter
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataController())
    }
}
