//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI
import CoreData

/// This `View` is the **entry-point** of the App and displays a list of all the ``DataController/counters``,
/// with options to add, delete and edit them.
struct MainView: View {
    @EnvironmentObject var dataController: DataController
    ///This state controls the size of the ``CounterCardView``
    @State var isAspectSmall = true
    @State var showSettings = false
    @ScaledMetric var counterHeight = 180
    @ScaledMetric var counterWidth = 360
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: isAspectSmall ? counterHeight : counterWidth))],spacing: 15) {
                    
                    ForEach(dataController.counters){ counter in
                        //MARK: Counter
                        Button(action: {showCreateView(counterIndex: dataController.getCounterIndex(counter: counter))}) {
                            CounterCardView(counter: counter, isSmall: isAspectSmall)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            //MARK: contextMenu
                                .contextMenu{
                                    
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
                        .buttonStyle(.plain)
                        .frame(width: isAspectSmall ? counterHeight : counterWidth, height: counterHeight)
                        .shadow(
                            color: .black.opacity(0.2),
                            radius: 5,
                            y: 5)
                        
                        
                    }
                }
                .padding([.top, .leading, .trailing])
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
                    //For better tappable area
                    .contentShape(Rectangle())
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
                    //For better tappable area
                    .contentShape(Rectangle())
                }
                //MARK: Add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showCreateView()
                    } label: {
                        Label("Add new counter", systemImage: "plus")
                    }
                    //For better tappable area
                    .contentShape(Rectangle())
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
        .sheet(isPresented: $isCreateViewActive){
            CreateView(showSheet: $isCreateViewActive, editingIndex: $editingIndex)
        }
    }
    
    @State var isCreateViewActive = false
    @State var editingIndex: Int? = nil
    
    func showCreateView(counterIndex: Int? = nil){
        self.editingIndex = counterIndex
        self.isCreateViewActive = true
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataController())
    }
}
