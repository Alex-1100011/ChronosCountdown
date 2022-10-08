//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

struct CreateView: View {
    ///Used to save the ``counter``
    @EnvironmentObject var dataController: DataController
    
    @State var counter = Counter()
    ///Used to dismiss the sheet
    @Binding var showSheet: Bool
    @State private var showSymbolSearch = false
    
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
                Button(action: {
                    //Save and dismiss
                    dataController.add(counter)
                    showSheet = false
                }) {
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
            SymbolSearchView(text: $counter.symbolName)
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(showSheet: .constant(true))
    }
}
