//
//  ContentView.swift
//  teste
//
//  Created by user on 21/05/23.
//

import SwiftUI

class Counter: ObservableObject {
    
    @Published var month = 0
    @Published var day = 0
    @Published var hour = 0
    @Published var minute = 0
    @Published var seconds = 0
    
    var selectedDate = Date()
    
    init(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            print(currentDate)
            
            let selectedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDateComponents = DateComponents()
            eventDateComponents.year = selectedComponents.year
            eventDateComponents.month = selectedComponents.month
            eventDateComponents.day = selectedComponents.day
            eventDateComponents.hour = selectedComponents.hour
            eventDateComponents.minute = selectedComponents.minute
            eventDateComponents.second = selectedComponents.second
            	
            let eventDate = calendar.date(from: eventDateComponents)
            
            let timeLeft = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if (timeLeft.second! >= 0) {
                self.month = timeLeft.month ?? 0
                self.day = timeLeft.day ?? 0
                self.hour = timeLeft.hour ?? 0
                self.minute = timeLeft.minute ?? 0
                self.seconds = timeLeft.second ?? 0
            }
        }
    }
}

struct ContentView: View {
    @StateObject var counter = Counter()
    var body: some View {
        VStack{
            
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]){ Text("selecione a data desejada")
            }
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(" \(counter.day) dias")
                Text(" \(counter.hour) horas")
                Text(" \(counter.minute) minutos")
                Text("\(counter.seconds) segundos")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
