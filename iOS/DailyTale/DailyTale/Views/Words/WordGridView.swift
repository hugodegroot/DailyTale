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
    
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8),
            GridItem(.flexible(), spacing: 8)
        ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(0..<wordsViewController.words.count, id: \.self) { index in
                    Text(wordsViewController.words[index])
                        .blur(radius: showBlur(wordCount: index) ? 0 : 10)
                        .font(.custom(settings.textFontString, size: 16))
                        .foregroundStyle(Color.textColor)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundColor(Color.highlightColor)
                        )
                }
            }
            .padding(.horizontal)
        }
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
