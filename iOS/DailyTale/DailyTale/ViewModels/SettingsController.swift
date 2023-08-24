//
//  SettingsController.swift
//  DailyTale
//
//  Created by Hugo de Groot on 12/08/2023.
//

import SwiftUI

class SettingsController: ObservableObject {
    @AppStorage("textcolorkey") var textColor: Color = .black
    @AppStorage("textfontkey") var textFontString: String = "System"
    @AppStorage("secondsInbetweenWordsKey") var secondsInbetweenWords: Int = 1
    @AppStorage("amountOfWordsKey") var amountOfWords: Int = 20
    
    var totalGameTime: Int {
        amountOfWords * secondsInbetweenWords
    }
    
    var availableFontFamilies: [String] {
        var font = UIFont.familyNames.sorted()
        font.insert("SF Pro", at: 0)
        return font
    }
    
    var availableFontsForSelectedFamily: [String] {
        return UIFont.fontNames(forFamilyName: textFontString)
    }
}
