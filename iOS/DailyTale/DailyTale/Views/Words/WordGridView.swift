//
//  WordGridView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 13/08/2023.
//

import SwiftUI

struct WordGridView: View {
    @ObservedObject private var wordsViewController = WordsViewController()
    private let wordSetOne: [String]
    private let wordSetTwo: [String]
    private let maxWords: Int
    
    private var showSecondRow: Bool {
        if wordsViewController.wordCount > (maxWords / 2) {
            return true
        }
        return false
    }
    
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ForEach(0..<maxWords, id: \.self) { wordCount in
                    GridRow {
                        Text(wordSetOne[wordCount])
                            .blur(radius: showBlur(wordCount: wordCount) ? 0 : 10)
                            
                    }
                }
            }
            
            HStack {
                ForEach(0..<maxWords, id: \.self) { wordCount in
                    GridRow {
                        Text(wordSetTwo[wordCount])
                            .blur(radius: showBlur(wordCount: wordCount + 5) ? 0 : 10)
                    }
                }
            }
        }
    }
    
    init(wordsViewController: WordsViewController) {
        let wordSetsSplit = wordsViewController.words.split()
        self.wordSetOne = wordSetsSplit.left
        self.wordSetTwo = wordSetsSplit.right
        self.maxWords = wordSetsSplit.left.count < wordSetsSplit.right.count ? wordSetsSplit.left.count : wordSetsSplit.right.count
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
        WordGridView(wordsViewController: WordsViewController())
    }
}
