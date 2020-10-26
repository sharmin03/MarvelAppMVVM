//
//  ContentView.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import SwiftUI
import UIKit
import struct Kingfisher.KFImage

struct CharacterListView: View {
    
    @ObservedObject var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { marvelCharacter in
                Spacer()
                ZStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        KFImage(URL(string: marvelCharacter.thumbnail)!)
                            .resizable()
                            .frame(width: 250, height: 150)
                            .scaledToFit()
                            .cornerRadius(10)
                        VStack(spacing: 5) {
                            Text(marvelCharacter.name).font(Font.system(.headline))
                            Text(marvelCharacter.description).font(Font.system(.subheadline)).multilineTextAlignment(.center)
                        }
                        }.onAppear {
                            let index = self.viewModel.characters.firstIndex(of: marvelCharacter)
                            let length = self.viewModel.characters.count
                            if index == (length - 5) {
                                self.viewModel.fetchCharacterList()
                            }
                        }
                    Spacer()
                    //Adding the navigation link on each tableView row
                    NavigationLink(destination: CharacterDetailView(name: marvelCharacter.name, description: marvelCharacter.description, image: marvelCharacter.thumbnail)) {
                            EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                    }
                }
            .navigationBarTitle(Text("Marvel Characters"))
            .font(Font.system(.largeTitle))
        }.onAppear {
            //fetching the data (equivalent to viewDidAppear in UIViewController)
            self.viewModel.fetchCharacterList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

