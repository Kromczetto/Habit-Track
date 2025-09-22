//
//  AddNewHabitView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 10/09/2025.
//

import SwiftUI

struct AddNewHabitView: View {
    @StateObject var addNewHabitViewModel = AddNewHabitViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Add your new habit")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.secondaryText)
                    .padding(.top, 80)
                VStack(alignment: .leading) {
                    TextField("Habit name", text: $addNewHabitViewModel.habitName)
                        .textFieldStyle(PlainTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    TextField("Habit priority", value: $addNewHabitViewModel.habitValue,
                              format: .number)
                        .textFieldStyle(PlainTextFieldStyle())
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                        .padding(.vertical, 10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray, lineWidth: 2)
                            )
                    Button {
                        addNewHabitViewModel.addHabit()
                    } label: {
                        Text("Add your new habit")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(addNewHabitViewModel.habitName != "" && (addNewHabitViewModel.habitValue != nil) ? Color.green : Color.neutralElement)
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                    }
                    .padding(.top, 40)
                    .disabled(!(addNewHabitViewModel.habitName != "" && (addNewHabitViewModel.habitValue != nil)))
                    .alert(addNewHabitViewModel.errorMessage, isPresented: $addNewHabitViewModel.isError) {
                        Button("OK", role: .cancel) {}
                    }
                }
                .padding(50)
                .padding(.top, -120)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            }
        }
    }
}

#Preview {
    AddNewHabitView()
}
