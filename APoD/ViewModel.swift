//
//  ViewModel.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/13/22.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var apod: [Apod] = []
    
    init() {
        self.get()
    }
    
}

extension ViewModel {
    func get() {
        Api.getImage { apod in
            self.apod = apod
            print(apod)
        }
    }
}
