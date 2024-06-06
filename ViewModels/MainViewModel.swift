//
//  MainViewModel.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 03/05/24.
//

import SwiftUI
import SwiftData

@Observable
class MainViewModel {
    
    /// The counter currently selected for editing
    var editingCounter: Counter? = nil
    /// The aspect of the Counter Cards
    var isAspectSmall = true
    var showCreateView = false
    var showSettings = false
    
    
    var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: cardWidth))]
    }
    
    var changeSizeButtonImage: String {
        isAspectSmall ? "rectangle.grid.2x2" : "rectangle.grid.1x2"
    }
    
    //TODO: Change on appear with device size (if iOS)
    private var largeCardWidth: CGFloat = 340
    
    var cardHeight: CGFloat = 160
    var cardWidth: CGFloat {
        isAspectSmall ? cardHeight : largeCardWidth
    }
    
    var navTitleFont: UIFont {
        let font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return UIFont(
            descriptor:
                font.fontDescriptor
                .withDesign(.rounded)?
                .withSymbolicTraits(.traitBold)
            ??
            font.fontDescriptor,
            size: font.pointSize
        )
    }
    
    func onCardTap(_ counter: Counter){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        editingCounter = counter
        showCreateView = true
    }
    
    func onAddTap() {
        editingCounter = nil
        showCreateView = true
    }
    
    func save(counter: Counter, context: ModelContext) {
        // Editing
        if let editingCounter {
            editingCounter.copy(from: counter)
        // New
        } else {
            context.insert(counter)
        }
        showCreateView = false
    }
    
    func onDeleteTap(_ counter: Counter, context: ModelContext){
        withAnimation {
            context.delete(counter)
        }
    }
    
    func onSettingsTap() {
        showSettings = true
    }
    
    func onChangeSizeTap() {
        withAnimation {
            isAspectSmall.toggle()
        }
    }
    
    func onShareTap(_ counter: Counter){
        //shareToStory(counter: counter, pattern: true)
    }
}
