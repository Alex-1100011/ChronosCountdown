//
//  SettingsView.swift
//  Chronos Countdown
//
//  Created by Alessandro Alberti on 19/09/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            
            List{
                
                Section("App icon"){
                    Text("App icon")
                }
                
                Section("About"){
                    Text("About")
                }
            }
            
            .navigationTitle("Settings")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
