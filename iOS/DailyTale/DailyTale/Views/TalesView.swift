//
//  TalesView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 06/08/2023.
//

import SwiftUI

struct TalesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: #keyPath(Tale.createdAt), ascending: false)]) var tales: FetchedResults<Tale>
    private let amountOfWords: Int
    private let dateFormatter = DateFormatter()
    private var groupedTales: [String: [Tale]] {
        var groupedTales = [String: [Tale]]()
        
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        for tale in tales {
            if let createdAt = tale.createdAt {
                if createdAt >= lastWeek {
                    let key = "Last Week"
                    if groupedTales[key] == nil {
                        groupedTales[key] = []
                    }
                    groupedTales[key]?.append(tale)
                } else {
                    let key = dateFormatter.string(from: createdAt)
                    if groupedTales[key] == nil {
                        groupedTales[key] = []
                    }
                    groupedTales[key]?.append(tale)
                }
            }
        }
        
        return groupedTales
    }
    
    var body: some View {
        VStack {
            List {
                NavigationLink {
                    WriterView(showGameOptions: true, amountOfWords: amountOfWords)
                } label: {
                    Text("New")
                }
                
                ForEach(groupedTales.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedTales[key] ?? [], id: \.id) { tale in
                            if let text = tale.text, let words = tale.words, let createdAt = tale.createdAt {
                                NavigationLink {
                                    WriterView(showGameOptions: false, text: text, words: words, amountOfWords: words.count)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(text)
                                            .lineLimit(2)
                                        
                                        Text(dateFormatter.string(from: createdAt))
                                            .font(.subheadline)
                                            .foregroundStyle(Color.gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("DailyTales")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(amountOfWords: Int) {
        self.amountOfWords = amountOfWords
        dateFormatter.dateFormat = "d MMM y"
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let tale = tales[index]
            moc.delete(tale)
            do {
                try moc.save()
            } catch {
                // TODO: Handle error
            }
        }
    }
}

struct TalesView_Previews: PreviewProvider {
    static var previews: some View {
        TalesView(amountOfWords: 10)
    }
}
