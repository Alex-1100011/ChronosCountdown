//
//  ContentView.swift
//  Shared
//
//  Created by Alessandro Alberti on 20/05/22.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var viewModel = MainViewModel()
    @Query private var counters: [Counter]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.gridColumns, spacing: 15) {
                    
                    ForEach(counters){ counter in
                        //MARK: CounterCard
                        Button(action: { viewModel.onCardTap(counter) }) {
                            CounterCardView(counter: counter, isSmall: viewModel.isAspectSmall)
                                .clipShape(.rect(cornerRadius: 30))
                                .contentShape(.contextMenuPreview, .rect(cornerRadius: 30))
                                .frame(width: viewModel.cardWidth, height: viewModel.cardHeight)
                                .hoverEffect()
                                .contextMenu {
                                    contextMenu(for: counter)
                                }
                        }
                        .buttonStyle(.plain)
                        .shadow(
                            color: counter.color.opacity(0.3),
                            radius: 10,
                            y: 5
                        )
                    }
                }
                .padding([.top, .leading, .trailing])
            }
            //Placeholder
            .overlay {
                if counters.isEmpty{
                    Image("Placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                }
            }
            //MARK: Toolbar
            .navigationBarTitle("Countdowns")
            .toolbar {
                // Settings button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        "Settings",
                        systemImage: "gear",
                        action: viewModel.onSettingsTap
                    )
                    ///For better tappable area
                    .contentShape(Rectangle())
                }
                
                // Change size button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        "Change card size",
                        systemImage: viewModel.changeSizeButtonImage,
                        action: viewModel.onChangeSizeTap
                    )
                    .contentShape(Rectangle())
                }
                
                // Add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        "Add new countdown",
                        systemImage: "plus",
                        action: viewModel.onAddTap
                    )
                    .contentShape(Rectangle())
                }
            }
        }
        .accentColor(.primary)
        //To avoid side list on iPad
        .navigationViewStyle(StackNavigationViewStyle())
        
        //MARK: Sheets
        .sheet(isPresented: $viewModel.showSettings){
            SettingsView()
        }
        .sheet(isPresented: $viewModel.showCreateView){
            CreateView(
                startingFrom: viewModel.editingCounter?.copy() ?? Counter(),
                isPresented: $viewModel.showCreateView
            ){ counter in
                viewModel.save(counter: counter, context: modelContext)
            }
        }
    }
    
    
    
    //MARK: contextMenu
    @ViewBuilder
    func contextMenu(for counter: Counter) -> some View {
        #if os(iOS)
        //Share
        Button(
            "Share story",
            systemImage: "camera.circle.fill",
            action: {
                viewModel.onShareTap(counter)
            }
        )
        #endif
        
        //Delete
        Button(
            "Delete",
            systemImage: "trash",
            role: .destructive,
            action: {
                viewModel.onDeleteTap(counter, context: modelContext)
            }
        )
    }
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: viewModel.navTitleFont]
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: Counter.self)
    }
}
