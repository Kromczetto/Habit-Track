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
    @FocusState private var isTextFieldFocus: Bool
 
    @State private var showFeedback = false
    @State private var feedbackColor = Color.green
    @State private var feedbackOffset = CGSize.zero
    @State private var feedbackOpacity = 0.5
    @State private var feedbackScale: CGFloat = 1.0
    
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @State private var showPaywall = false
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            
            if showFeedback {
              ZStack {
                  Circle()
                      .fill(feedbackColor)
                      .frame(width: 80, height: 80)
                  
                  Image(systemName: "checkmark")
                      .font(.system(size: 35, weight: .bold))
                      .foregroundColor(.white)
              }
              .scaleEffect(feedbackScale)
              .offset(feedbackOffset)
              .opacity(feedbackOpacity)
              .transition(.scale.combined(with: .opacity))
              .animation(.easeInOut(duration: 0.4), value: showFeedback)
          }
            
            VStack {
                Text("Add your new habit")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7) 
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
                        .focused($isTextFieldFocus)
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
                    
                    if !subscriptionManager.isPremium {
                        HStack {
                            Text("Habits:")
                            Text("\(habitViewModel.habits.count)/3")
                                .fontWeight(.bold)
                                .foregroundColor(habitViewModel.habits.count >= 3 ? .red : .green)
                        }
                    }
                    Button {
                        if habitViewModel.canAddHabbit(isPremium: subscriptionManager.isPremium) {
                            habitViewModel.addHabit()
                            isTextFieldFocus = false
                            if !habitViewModel.isError {
                                triggerFeedbackAnimation()
                            }
                        } else {
                            showPaywall = true
                        }
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
                    .disabled(!subscriptionManager.isPremium && habitViewModel.habits.count >= 3)
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
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 50 {
                        UIApplication.shared.hideKeyboard()
                    }
                }
        )
        .onTapGesture {
            isTextFieldFocus = false
            UIApplication.shared.hideKeyboard()
        }
        .sheet(isPresented: $showPaywall) {
            VStack(spacing: 20) {
                Text("Go Premium")
                    .font(.largeTitle)
                
                Text("• Unlimited habits\n• Calendar access")
                        
                Button("Subscribe for $0.99") {
                    Task {
                        await subscriptionManager.purchase()
                        showPaywall = false
                    }
                }
                
                Button("Restore purchases") {
                    Task {
                        await subscriptionManager.restore()
                    }
                }
            }
            .padding()
        }
    }
    
    private func triggerFeedbackAnimation() {
           feedbackColor = .green
           feedbackOffset = .zero
           feedbackOpacity = 1.0
           feedbackScale = 1.0
           
           withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
               showFeedback = true
           }

           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               withAnimation(.easeInOut(duration: 0.5)) {
                   feedbackColor = .gray
               }
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
               withAnimation(.easeInOut(duration: 0.8)) {
                   feedbackOffset = CGSize(width: -130, height: 400)
                   feedbackOpacity = 0.0
                   feedbackScale = 0.4
               }
           }

           DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
               showFeedback = false
           }
       }
}


