//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

///This `View` lets users **create** and **edit** a ``Counter``
struct CreateView: View {
    ///Used to save the ``counter``
    @EnvironmentObject var dataController: DataController
    ///The temporary counter to be edited
    ///
    ///Changes are applied to this variable rather than directly on the list so that all the changes can be discarded.
    ///It will be saved only when the ``CreateView/save()`` method gets called
    @State private var counter = Counter()
    ///To dismiss the current sheet
    @Binding var showSheet: Bool
    ///To display the search sheet
    @State private var showSymbolSearch = false
    ///The index of the counter in the ``DataController/counters`` list to be modified
    ///
    ///If `nil` this view creates a new counter rather than editing one
    var editingIndex: Int?
    ///When the `View` should save an existing counter rather than creating a new one
    private var isEditing: Bool{
        editingIndex != nil
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            CreateTopView(counter: $counter)
            List {
                Section("Background"){
                    BackgroundPicker(color: $counter.color, image: $counter.image)
                        .padding(.vertical)
                }
                
                Section("Date"){
                    DatePicker("Date", selection: $counter.date, displayedComponents: .date)
                        .accentColor(counter.color)
                        .datePickerStyle(.graphical)
                }
                
                Section("Symbol"){
                    SymbolPicker(color: counter.color, selectedSymbol: $counter.symbolName, showSearch: $showSymbolSearch)
                        .padding(.vertical)
                }
            }
            .listStyle(.insetGrouped)
            
            //MARK: - Save
            .safeAreaInset(edge: .bottom){
                Button(action: save) {
                    //Save Button
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(10.0)
                    .background(counter.color.cornerRadius(15))
                    .padding([.top, .leading, .trailing])
                    .background(
                        counter.color
                            .edgesIgnoringSafeArea(.bottom)
                            .opacity(0.1)
                    )
                    .background(.ultraThinMaterial)
                }
        }
        }
        .sheet(isPresented: $showSymbolSearch){
            SymbolsView(
                symbol: $counter.symbolName,
                showSymbolsView: $showSymbolSearch,
                color: counter.color
            )
        }
        .onAppear{
            if let editingIndex {
                self.counter = dataController.counters[editingIndex]
            }
        }
    }
    
    func save(){
        
        if isEditing {
            //Modify an existing counter
            dataController.update(counter)
            
        } else {
            //Add a new counter
            dataController.add(counter)
        }
        //Dismiss
        showSheet = false
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(showSheet: .constant(true))
    }
}
