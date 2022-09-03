//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI

struct CreateView: View {
    @State var counter = Counter(name: "", date: Date(), color: Color(hex: "027AFF"), symbolName: "hourglass")
    
    var body: some View {
        List {
            Section("Background"){
                BackgroundPicker(color: $counter.color)
                    .padding(.vertical)
            }
            
            Section("Date"){
                DatePicker("Date", selection: $counter.date, displayedComponents: .date)
                    .accentColor(counter.color)
                    .datePickerStyle(.graphical)
            }
            
            Section("Symbol"){
                SymbolPicker(color: counter.color, selectedSymbol: $counter.symbolName)
                    .padding(.vertical)
            }
        }
        .listStyle(.insetGrouped)
        
        //MARK: - Save
        .safeAreaInset(edge: .bottom){
            Button(action: {
                //Save and dismiss
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
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
