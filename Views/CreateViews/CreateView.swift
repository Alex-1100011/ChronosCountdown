//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI
import SwiftData
import WidgetKit


struct CreateView: View {
    @State private var viewModel: CreateViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0){
                
                CreateHeaderView(counter: $viewModel.counter, showSheet: $isPresented, offset: $viewModel.scrollOffset)
                    .frame(height: viewModel.headerHeight)
                    /// To  clip the image in the view
                    .clipped()
                    .offset(y: viewModel.headerOffset)
                    /// Give a constant height in the list placement
                    .frame(height: 180)
                    
                    /// To bring it in front of the scrolling elements
                    .zIndex(1)
                
                
                BackgroundPicker(color: $viewModel.counter.color, image: $viewModel.counter.image)
                    .insetGroupedStyle("Background")
                    .tint(viewModel.color)
                
                Group {
                    DatePicker("Date", selection: $viewModel.counter.date, displayedComponents: viewModel.datePickerComponents)
                        .accentColor(viewModel.color)
                        .datePickerStyle(.graphical)
                    Toggle("Include Time", isOn: $viewModel.includeTime)
                        .tint(viewModel.color)
                }
                .insetGroupedStyle("Date")
                
                
                SymbolPicker(
                    color: viewModel.color,
                    selectedSymbol: $viewModel.counter.symbolName,
                    showSearch: $viewModel.showSymbolSearch
                )
                .insetGroupedStyle("Symbol", padding: 0)
                
            }
            .offset(coordinateSpace: .named("Scroll")){ offset in
                viewModel.scrollOffset = offset
            }
            
        }
        .scrollIndicators(.hidden)
        .background {
            Color(uiColor: UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        }
        .coordinateSpace(name: "Scroll")
        //MARK: - Save
        .safeAreaInset(edge: .bottom){
            
            Button(action: viewModel.didTapSave) {
                //Save Button
                Text("Save")
                    .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .padding(10.0)
                    .background(viewModel.color.cornerRadius(15))
                    .padding([.top, .horizontal])
                    //Add extra padding on iPad
//                    .if(UIDevice.current.userInterfaceIdiom == .pad){ view in
//                        view
//                            .padding(.bottom)
//                    }
                    .background(
                        viewModel.color
                            .edgesIgnoringSafeArea([.bottom, .horizontal])
                            .opacity(0.1)
                    )
                    .background(.ultraThinMaterial)
            }
        }
        .sheet(isPresented: $viewModel.showSymbolSearch){
            SymbolsView(
                symbol: $viewModel.counter.symbolName,
                showSymbolsView: $viewModel.showSymbolSearch,
                color: viewModel.color
            )
        }
    }
    
    //MARK: Init
    init(startingFrom counter: Counter = Counter(), isPresented: Binding<Bool>, onSave: @escaping (Counter)->()) {
        self.viewModel = CreateViewModel(counter: counter, onSave: onSave)
        self._isPresented = isPresented
    }
}


#Preview {
    swiftDataPreview {
        CreateView(isPresented: .constant(false), onSave: { _ in })
    }
}
