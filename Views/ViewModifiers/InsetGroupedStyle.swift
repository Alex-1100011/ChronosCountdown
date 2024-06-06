//
//  InsetGroupedStyle.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 21/11/22.
//

import SwiftUI

struct InsetGrouped: ViewModifier {
    var title: String
    var padding: CGFloat?
    @Environment(\.colorScheme) var colorScheme
    
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.leading)
            
            content
                .padding(.all, padding)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(uiColor: UIColor.secondarySystemGroupedBackground))
                }
                
        }
        .padding()
        
    }
}

extension View {
    func insetGroupedStyle(_ title: String, padding: CGFloat? = nil) -> some View {
        modifier(InsetGrouped(title: title, padding: padding))
    }
}

struct InsetGroupedStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            Text("Content")
                .insetGroupedStyle("Title")
        }
        
    }
}
