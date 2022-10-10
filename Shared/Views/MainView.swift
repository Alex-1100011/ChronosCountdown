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
    @State var showSettings = false
    
    var body: some View {
        NavigationView {
           ScrollView {
               LazyVGrid(columns: [GridItem(.adaptive(minimum: isAspectSmall ? 180 : 360))],spacing: 25) {
                   
                    ForEach(dataController.counters){ counter in
                        //MARK: Counter
                        CounterCardView(counter: counter, isSmall: isAspectSmall)
                            .frame(width: isAspectSmall ? 180 : 360, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        //MARK: contextMenu
                            .contextMenu{
                                //Edit
                                Button(action: {
                                    withAnimation{
                                        
                                    }
                                }){
                                    Text("Edit")
                                    Image(systemName: "square.and.pencil")
                                }
                                
                                //Delete
                                Button(role: .destructive, action: {
                                    withAnimation{
                                        dataController.delete(counter)
                                    }
                                }){
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            .navigationBarTitle("Counters")
            //MARK: navigationBarItems
            .toolbar {
                //MARK: Settings button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        showSettings = true
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                //MARK: Change size button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        withAnimation{
                            isAspectSmall.toggle()
                        }
                    } label: {
                        Label("Change card size", systemImage: isAspectSmall ? "rectangle.grid.2x2" : "rectangle.grid.1x2")
                    }
                }
                //MARK: Add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showCreateView = true
                    } label: {
                        Label("Add new counter", systemImage: "plus")
                    }
                }
            }
        }
        //To avoid side list on iPad
        .navigationViewStyle(StackNavigationViewStyle())
        //MARK: SettingsView
        .sheet(isPresented: $showSettings){
            SettingsView()
            // datacontroller.add counter
        }
        //MARK: CreateView
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
