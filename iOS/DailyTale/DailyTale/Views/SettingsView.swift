//
//  SettingsView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 04/08/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var settings: SettingsController
    @State private var isFontPickerPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ColorPicker("Text color", selection: $settings.textColor, supportsOpacity: false)
                    
                    // TODO: Set to 5...60
                    Stepper(value: $settings.secondsInbetweenWords, in: 1...60, step: 1) {
                        Text("Seconds in between words: \(settings.secondsInbetweenWords)")
                    }
                    
                    // TODO: Set to 5...20, step 5
                    Stepper(value: settings.$amountOfWords, in: 2...20, step: 2) {
                        Text("Amount of words: \(settings.amountOfWords)")
                    }
                    
                    Picker("Font", selection: $settings.textFontString) {
                        ForEach(settings.availableFontFamilies, id: \.self) { fontFamily in
                            Text(fontFamily)
                                .font(.custom(fontFamily, size: 12))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundColor)
            .scrollContentBackground(.hidden)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.backgroundColor)
    }
    
    init(settings: SettingsController) {
        self.settings = settings
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: SettingsController())
    }
}
