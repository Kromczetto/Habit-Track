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
                Text("Add your new habit")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondaryText)
                    .padding(.top, 80)
                Spacer()
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
                    HStack {
                        Text("Value of the habit")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondaryText)
                        Picker("Habit Value", selection: $addNewHabitViewModel.habitValue) {
                            ForEach(1...10, id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                    }
                    Spacer()
                    Button {
                        addNewHabitViewModel.addHabit()
                    } label: {
                        Text("Add your new habit")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(addNewHabitViewModel.habitName.trimmingCharacters(in: .whitespaces).count > 3 ? Color.green : Color.neutralElement)
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                    }
                    .padding(.top, 40)
                    .disabled(addNewHabitViewModel.habitName.trimmingCharacters(in: .whitespaces).count > 3 ? false : true)
                    .alert(addNewHabitViewModel.errorMessage, isPresented: $addNewHabitViewModel.isError) {
                        Button("OK", role: .cancel) {}
                    }
                }
                .padding(50)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            }
        }
    }
}

#Preview {
    AddNewHabitView()
}
