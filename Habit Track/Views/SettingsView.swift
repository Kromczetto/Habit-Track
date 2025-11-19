//
//  SettingsView.swift
//  Habit Track
//
//  Created by Kuba Kromołowski on 13/11/2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    @State private var languages = ["Polski", "English", "Spanish"]
    @State private var selectedLanguage: String = "English"
    
    var languageCodes = [
        "Polski": "pl",
        "English": "en",
        "Spanish": "es"
    ]
    
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
            .onAppear {
                let currentCode = appLanguageManager.locale.identifier
                
                if let languageName = languageCodes.first( where: { $0.value == currentCode })?.key {
                    selectedLanguage = languageName
                }
                print(selectedLanguage)
            }
          
            VStack {
                Spacer()
                Button {
                    print(selectedLanguage)
                    if let code = languageCodes[selectedLanguage] {
                        appLanguageManager.setLanguage(code)
                    } else {
                        print("Problem with language setting")
                    }
                } label: {
                    Text("Save changes")
                        .foregroundStyle(.white)
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.green)
                        .cornerRadius(10)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
                }
            }
            
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

#Preview() {
    SettingsView()
}
