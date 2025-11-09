//
//  CalendarView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 12/10/2025.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth: Date = Date.now
    @State private var currentDay: Date = Date.now
    @State private var days: [Date] = []
    
    let daysOfWeek = CalendarViewModel.capitalizedFirstLetterOfWeek()
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity)
                }
            }
            .onAppear {
                days = CalendarViewModel.displayCalendar(Date.now)
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days, id: \.self) { day in
                    if day < currentDay {
                        Text(day, format: .dateTime.day())
                            .foregroundColor(.gray)
                            .padding(6)
                            .frame(width: 35, height: 35)
                    } else {
                        Text(day, format: . dateTime.day())
                            .foregroundColor(.black)
                            .padding(6)
                            .frame(width: 35, height: 35)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    print("left")
                } label: {
                    Image(systemName: "arrow.left")
                }
                Button {
                    print("right")
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
            
            Spacer()
        }
        .padding(25)
    }
        
}

#Preview {
    CalendarView()
}
