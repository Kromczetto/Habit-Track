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
    @State var checkDays: [Date: Bool]
    
    private let formater = DateFormatter()
    @State var monthYearString: String = ""
    
    
    let daysOfWeek = CalendarViewModel.capitalizedFirstLetterOfWeek()
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(monthYearString)
                    .foregroundColor(.blue)
                    .bold()
                    .font(.system(size: 24))
                    .onAppear {
                        formater.dateFormat = "MMMM yyyy"
                        monthYearString = formater.string(from: currentMonth)
                    }
                    .onChange(of: currentMonth) {
                        formater.dateFormat = "MMMM yyyy"
                        monthYearString = formater.string(from: currentMonth)
                    }
                Spacer()
            }
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
                    if day < currentDay && !CalendarViewModel.isTheSameDay(day, currentDay){
                        Text(day, format: .dateTime.day())
                            .foregroundColor(.gray)
                            .padding(6)
                            .frame(width: 35, height: 35)
                            .overlay(
                              Circle()
                                .stroke(Color.blue, lineWidth: CalendarViewModel.hasHabitBeenDone(day, checkDays) ? 2 : 0)
                          )
                    } else {
                        Text(day, format: . dateTime.day())
                            .foregroundColor(.black)
                            .padding(6)
                            .frame(width: 35, height: 35)
                            .overlay(
                              Circle()
                                .stroke(Color.blue, lineWidth: CalendarViewModel.hasHabitBeenDone(day, checkDays) ? 2 : 0)
                          )
                    }
                }
            }
            .frame(height: 350, alignment: .top)
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                    days = CalendarViewModel.displayCalendar(currentMonth)
                } label: {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 40))
                }
                Spacer()
                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                    days = CalendarViewModel.displayCalendar(currentMonth)
                } label: {
                    Image(systemName: "arrow.right.circle")
                        .font(.system(size: 40))
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding(25)
    }
        
}

#Preview {
    CalendarView(checkDays: [Date(): true])
}
