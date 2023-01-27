//
//  SwiftUIView.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/13/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var appState: AppState
    @State private var date = Date()
    @ObservedObject var view = Api()
    //@Published var newDate: String? = nil
        var body: some View {
            VStack {
                Text("Choose A Date!")
                    .font(.largeTitle)
                DatePicker("Choose a date!", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .frame(maxHeight: 400)
                    
                Text("Date: \(date, format: .dateTime.year().month().day())")
                Spacer()
                Button("Submit") {
                    appState.myUrl = "https://api.nasa.gov/planetary/apod?api_key=tt2KiL5uaiSqD406azLXuG0AuREUKRi7Do4Wx9qL"
                    
                    let formatDate = DateFormatter()
                    formatDate.dateFormat = "yyyy-MM-dd"
                    let dateStr = formatDate.string(from: date)
                    appState.myUrl = appState.myUrl + "&date=\(dateStr)"

                    appState.dateChange = false
                }
            }
         
        }
    func printDate(selection: Date){
        print(self.date)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
