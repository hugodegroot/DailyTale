//
//  HomeView.swift
//  DailyTale
//
//  Created by Hugo de Groot on 06/08/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var settings = SettingsController()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            NavigationStack {
                TalesView()
                    .toolbar {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.black)
                        }
                    }
            }
        }
        .environmentObject(settings)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $showingSheet, content: {
            SettingsView(settings: settings)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
