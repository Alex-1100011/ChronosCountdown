//
//  CreateView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 01/09/22.
//

import SwiftUI
import WidgetKit

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
    ///If `nil` this view creates a new counter rather than editing one.
    ///Must be a Binding otherwise .sheet in the ``MainView`` won't pass an updated value.
    @Binding var editingIndex: Int?
    ///When the `View` should save an existing counter rather than creating a new one
    private var isEditing: Bool{
        editingIndex != nil
    }
    
    @State var scrollOffset:CGFloat = 0
    let headerCompactSize: CGFloat = 100
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0){
                
                CreateHeaderView(counter: $counter, showSheet: $showSheet, offset: $scrollOffset)
                    .frame(height: 180 + (scrollOffset > 0 ? scrollOffset : 0))
                    .clipped()
                    .zIndex(1)
                    .offset(y:
                            //Compact header
                            scrollOffset < -headerCompactSize ? (-scrollOffset - headerCompactSize) :
                            //Large header
                            (scrollOffset > 0 ? -scrollOffset/2 : 0)
                    )
                    //For the spacing in the list
                    .frame(height: 180)
                    
                
                BackgroundPicker(color: $counter.color, image: $counter.image)
                    .insetGroupedStyle("Background")
                    
                
                
                
                
                    
                DatePicker("Date", selection: $counter.date, displayedComponents: .date)
                    .accentColor(counter.color)
                    .datePickerStyle(.graphical)
                    .insetGroupedStyle("Date")
                
                
                    
                SymbolPicker(color: counter.color, selectedSymbol: $counter.symbolName, showSearch: $showSymbolSearch)
                    .insetGroupedStyle("Symbol", padding: 0)
                
            }
            .offset(coordinateSpace: .named("Scroll")){ offset in
                scrollOffset = offset
            }
            
        }
        .scrollIndicators(.hidden)
        .background{
            Color(uiColor: UIColor.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
        }
        .coordinateSpace(name: "Scroll")
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
                    .padding([.top, .horizontal])
                    //Add extra padding on iPad
                    .if(UIDevice.current.userInterfaceIdiom == .pad){ view in
                        view
                            .padding(.bottom)
                    }
                    
                    .background(
                        counter.color
                            .edgesIgnoringSafeArea([.bottom, .horizontal])
                            .opacity(0.1)
                    )
                    .background(.ultraThinMaterial)
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
            WidgetCenter.shared.reloadAllTimelines()
        } else {
            //Add a new counter
            dataController.add(counter)
            //If the new counter is the first to be added
            if dataController.counters.count == 1 {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        //Dismiss
        showSheet = false
    }
    
    init(showSheet: Binding<Bool>, editingIndex: Binding <Int?>? = nil) {
        self._showSheet = showSheet
        self._editingIndex = editingIndex ?? .constant(nil)
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(showSheet: .constant(true))
    }
}


// MARK: Offset Preference Key
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// Offset View Extension
extension View{
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace, completion: @escaping (CGFloat) -> ()) -> some View {
        self.overlay {
            GeometryReader{ proxy in
                let minY = proxy.frame(in: coordinateSpace).minY
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange (OffsetKey.self) { value in
                        completion (value)
                    }
            }
        }
    }
}



//.coordinateSpace(name: "Scroll")
