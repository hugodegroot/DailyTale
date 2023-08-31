//
//  WriterView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 04/08/2023.
//

import SwiftUI

struct WriterView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject private var settings: SettingsController
    @StateObject private var wordsViewController: WordsViewController
    
    @State private var timerIsDone = false
    @FocusState private var focusOnTexfield
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                WordGridView(wordsViewController: wordsViewController)
                    .padding(.bottom)
                
                Divider()
                
                 if !wordsViewController.showGameOptions {
                    scrollViewTextField
                } else {
                    vStackTextField
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
            
            if wordsViewController.showGameOptions {
                HStack() {
                    if (wordsViewController.gameActive) {
                        Button {
                            stopGame()
                        } label: {
                            Image(systemName: "stop.fill")
                                .foregroundColor(.white)
                                .frame(width: 48, height: 48)
                                .padding(.horizontal)
                                .background(Circle().foregroundColor(Color.secondaryColor))
                        }
                    } else {
                        Button {
                            startGame()
                        } label: {
                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                                .frame(width: 48, height: 48)
                                .padding(.horizontal)
                                .background(Circle().foregroundColor(.primaryColor))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            Color.backgroundColor
        )
        .onReceive(timer) { _ in
            onSecondElapesed()
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        ScrollView {
            TextField(wordsViewController.placeholder, text: $wordsViewController.text, axis: .vertical)
                .foregroundColor(settings.textColor)
                .accentColor(.yellow)
                .font(.custom(settings.textFontString, size: 16))
                .disabled(!wordsViewController.gameActive)
                .focused($focusOnTexfield)
                .padding([.horizontal, .top])
        }
    }
    
    @ViewBuilder
    private var scrollViewTextField: some View {
        ScrollView {
            textField
        }
    }
    
    @ViewBuilder
    private var vStackTextField: some View {
        VStack {
            textField
        }
    }
    
    init(
        showGameOptions: Bool,
        text: String = "",
        words: [String] = [],
        amountOfWords: Int
    ) {
        self._wordsViewController = StateObject(wrappedValue: WordsViewController(words: words, showGameOptions: showGameOptions, text: text, amountOfWords: amountOfWords))
        }
    
    private func onSecondElapesed() {
        if (wordsViewController.gameActive) {
            if wordsViewController.wordCount < Int(settings.amountOfWords) {
                wordsViewController.wordCount += 1
            } else {
                stopGame(gameFinished: true)
            }
        }
    }
    
    private func startGame() {
        timer = Timer.publish(every: Double(settings.secondsInbetweenWords), on: .main, in: .common).autoconnect()
        wordsViewController.gameActive.toggle()
        focusOnTexfield = true
        wordsViewController.wordCount = 1
    }
    
    private func stopGame(gameFinished: Bool = false) {
        self.timer.upstream.connect().cancel()
        wordsViewController.gameActive = false
        wordsViewController.wordCount = 0
        focusOnTexfield = false
        saveText()
        if (!gameFinished) {
            wordsViewController.text = ""
        }
    }
    
    private func saveText() {
        if (wordsViewController.text.isEmpty || wordsViewController.words.isEmpty) {
            // TODO: Handle error
            return
        }
        let dailyTale = Tale(context: moc)
        dailyTale.id = UUID()
        dailyTale.text = wordsViewController.text
        dailyTale.createdAt = Date.now
        dailyTale.words = wordsViewController.words
        do {
            try moc.save()
        } catch {
            // TODO: Handle error
            print("Oh no")
        }
    }
}

struct WriterView_Previews: PreviewProvider {
    static var previews: some View {
        WriterView(showGameOptions: true, amountOfWords: 10)
    }
}
