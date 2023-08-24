//
//  WordGridView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 13/08/2023.
//

import ExyteGrid
import SwiftUI

struct WordGridView: View {
    @EnvironmentObject private var settings: SettingsController
    @ObservedObject private var wordsViewController: WordsViewController
    
    var body: some View {
        VStack {
            Grid(0..<wordsViewController.words.count, id: \.self, tracks: [.fit, .fit, .fit, .fit]) { index in
                Text(wordsViewController.words[index])
                    .blur(radius: showBlur(wordCount: index) ? 0 : 10)
                    .font(.custom(settings.textFontString, size: 16))
            }
        }
        .frame(maxHeight: 80)
    }
    
    init(wordsViewController: WordsViewController) {
        self.wordsViewController = wordsViewController
    }
    
    private func showBlur(wordCount: Int) -> Bool {
        if wordsViewController.showGameOptions {
            return wordsViewController.wordCount > wordCount
        } else {
            return true
        }
    }
}

struct WordGridView_Previews: PreviewProvider {
    static var previews: some View {
        WordGridView(wordsViewController: WordsViewController(amountOfWords: 0))
    }
}
