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
                    WriterView(showGameOptions: true)
                } label: {
                    Text("New")
                }
                
                ForEach(groupedTales.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedTales[key] ?? [], id: \.id) { tale in
                            if let text = tale.text, let words = tale.words {
                                NavigationLink {
                                    WriterView(showGameOptions: false, text: text, words: words)
                                } label: {
                                    Text(text)
                                        .lineLimit(2)
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
        TalesView()
    }
}
