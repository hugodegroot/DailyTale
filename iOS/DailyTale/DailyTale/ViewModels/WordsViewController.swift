//
//  WordsViewController.swift
//  DailyTale
//
//  Created by Hugo de Groot on 14/08/2023.
//

import Foundation
import SwiftUI

class WordsViewController: ObservableObject {
    @Environment(\.managedObjectContext) private var moc
    @Published var wordList: [String] = []
    @Published var wordCount: Int = 0
    @Published var words = [String]()
    @Published var text: String
    @Published var gameActive = false
    let showGameOptions: Bool
    
    var placeholder: String {
        if !showGameOptions {
            return text
        }
        if gameActive {
            return ""
        }
        return "Press Start to begin!"
    }
    
    init(words: [String] = [], showGameOptions: Bool = false, text: String = "") {
        self.showGameOptions = showGameOptions
        self.text = text
        if words.isEmpty {
            loadData()
            for _ in (0..<Int(SettingsController.amountOfWords)) {
                let randomNumber = Int.random(in: 0..<wordList.count)
                self.words.append(wordList[randomNumber])
            }
        } else {
            self.words = words
        }
    }
    
    func loadData()  {
        do {
            if let url = Bundle.main.url(forResource: "wordlist", withExtension: "json") {
                let data = try Data(contentsOf: url)
                let wordList = try JSONDecoder().decode([String].self, from: data)
                self.wordList = wordList
            }
        } catch {
            // TODO: Handle error
            print("File not found")
        }
    }
}
