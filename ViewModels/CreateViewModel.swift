//
//  CreateViewModel.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 04/05/24.
//

import SwiftUI

@Observable
class CreateViewModel {
    var counter: Counter
    var showSymbolSearch = false
    var includeTime = false
    var scrollOffset: CGFloat = 0
    
    
    let headerCompactSize: CGFloat = 100
    var headerHeight: CGFloat {
        180 + (scrollOffset > 0 ? scrollOffset : 0)
    }
    var headerOffset: CGFloat {
        //Compact header
        scrollOffset < -headerCompactSize ? (-scrollOffset - headerCompactSize) :
        //Large header
        (scrollOffset > 0 ? -scrollOffset/2 : 0)
    }
    var color: Color {
        return counter.color
    }
    
    var datePickerComponents: DatePickerComponents {
        [.date, includeTime ? .hourAndMinute : .date]
    }
    
    
    let onSave: (Counter) -> Void
    
    func didTapSave(){
        onSave(counter)
    }
    
    init(counter: Counter, onSave: @escaping (Counter) -> Void) {
        self.counter = counter
        self.onSave = onSave
    }
}


