//
//  SettingsView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

///This `View` lets the user change the App Icon and other settings
struct SettingsView: View {
    @ScaledMetric var appIconSize: CGFloat = 70
    var body: some View {
        NavigationView {
            
            List{
                
                Section("App icon"){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: appIconSize))]) {
                        ForEach(icons, id: \.self){ icon in
                            AppIconView(name: icon, size: appIconSize)
                        }
                    }
                }
                
                Section("About"){
                    Link("About", destination: URL(string: "https://alessandro-alberti.notion.site/Chronos-Beta-Test-6147a650d7dd4a3190c2ae8c7d84b023")!)
                        
                }
            }
            
            .navigationTitle("Settings")
        }
    }
    
    var icons = ["Default", "Orange", "Green", "Black", "Beta", "DALLE", "Pixel"]
    
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
