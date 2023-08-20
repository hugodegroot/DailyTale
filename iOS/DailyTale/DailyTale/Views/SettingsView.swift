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
                    
                    Picker("Font", selection: $settings.textFontString) {
                        ForEach(settings.availableFontFamilies, id: \.self) { fontFamily in
                            Text(fontFamily)
                        }
                    }
                    
                    // TODO: Set to 5...60
                    Stepper(value: $settings.secondsInbetweenWords, in: 1...60, step: 1) {
                        Text("Seconds in between words: \(Int(settings.secondsInbetweenWords.rounded(.toNearestOrAwayFromZero)))")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Constants.backgroundColor)
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
        .background(Constants.backgroundColor)
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
