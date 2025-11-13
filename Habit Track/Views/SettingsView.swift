//
//  SettingsView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 13/11/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var languages = ["Polski", "Angielski"]
    @State private var selectedLanguage: String = "Polski"
    
    var body: some View {
        ZStack {
            List {
                Picker("Language:", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { lang in
                        Text(lang).tag(lang)
                    }
                }
                Button("Clear app data") {
                    print("Clear app data")
                }
                .foregroundStyle(.red)
            }
            Spacer()
            Button("Save changes") {
                print(selectedLanguage)
            }
            .foregroundStyle(.white)
            .background(.green)
            Spacer()
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
