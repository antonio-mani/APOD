//
//  ContentView.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/8/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var view = Api()
    @EnvironmentObject var appState: AppState
    @State var changeDate = false
    @State var urlErr = false
    
    var body: some View {
        
        NavigationView {
            Group {
                if view.hasLoaded {
                    VStack {
                        Text(view.title!)
                            .font(.title)
                        if view.image != nil {
                        GeometryReader { geo in
                            Image(uiImage: view.image!)
                                .resizable()
                                
                                .frame(width: geo.size.width * 0.97 )
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                        } else {
                            Spacer()
                            Text("No Image!")
                        }
                        ScrollView {
                            Text(view.explanation!)
                                .font(.body)
                                .padding()
                                //.padding(.bottom, 1)
                                //.padding(.all, 2)
                            Text(view.copyright!)
                                .font(.footnote)
                        }.padding(.all, 0.5)
                    }
                   
                } else if view.requestErr {
                    Text("Invalid Date!")
                    
                    } else {
                    
                    Text("Loading APOD...")
                    }
            }.onAppear {
                
                self.view.loadImage(urlStr: appState.myUrl)
            }
            .navigationTitle("APOD")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Change Date") {
                        appState.dateChange = true
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
