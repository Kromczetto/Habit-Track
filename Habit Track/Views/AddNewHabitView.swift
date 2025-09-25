//
//  AddNewHabitView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 10/09/2025.
//

import SwiftUI
import SwiftData

struct AddNewHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var habitViewModel: HabitViewModel
    
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
                    TextField("Habit name", text: $habitViewModel.habitName)
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
                        Picker("Habit Value", selection: $habitViewModel.habitValue) {
                            ForEach(1...10, id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                    }
                    Spacer()
                    Button {
                        habitViewModel.addHabit()
                    } label: {
                        Text("Add your new habit")
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(habitViewModel.habitName.trimmingCharacters(in: .whitespaces).count > 3 ? Color.green : Color.neutralElement)
                            .foregroundStyle(Color.white)
                            .cornerRadius(10)
                            .padding(.vertical, 20)
                    }
                    .padding(.top, 40)
                    .disabled(habitViewModel.habitName.trimmingCharacters(in: .whitespaces).count > 3 ? false : true)
                    .alert(habitViewModel.errorMessage, isPresented: $habitViewModel.isError) {
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


