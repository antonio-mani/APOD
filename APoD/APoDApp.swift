//
//  APoDApp.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/8/22.
//

import SwiftUI
import Foundation

class AppState: ObservableObject {
    @Published var dateChange: Bool
    //@Published var reqError: Bool
    @Published var myUrl = "https://api.nasa.gov/planetary/apod?api_key=tt2KiL5uaiSqD406azLXuG0AuREUKRi7Do4Wx9qL"

    
    init(dateChange: Bool) {
        self.dateChange = dateChange
        //self.reqError = false
    }
}


@main
struct APoDApp: App {
    @ObservedObject var appState = AppState(dateChange: false)
    var body: some Scene {
        WindowGroup {
            if appState.dateChange {
                CalendarView()
                    .environmentObject(appState)
            } else {
                ContentView()
                    .environmentObject(appState)
            }
            
        }
    }
}
