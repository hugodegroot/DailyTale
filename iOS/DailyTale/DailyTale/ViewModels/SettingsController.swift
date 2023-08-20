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
    @AppStorage("secondsInbetweenWordsKey") var secondsInbetweenWords: Double = 1
    @AppStorage("amountOfWordsKey") static var amountOfWords: Double = 10
    
    var totalGameTime: Double {
        SettingsController.amountOfWords * secondsInbetweenWords
    }
    
    var availableFontFamilies: [String] {
        return UIFont.familyNames.sorted()
    }
    
    var availableFontsForSelectedFamily: [String] {
        return UIFont.fontNames(forFamilyName: textFontString)
    }
}
