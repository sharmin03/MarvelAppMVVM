//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import Moya

class CharacterListViewModel: ObservableObject {
    
    @Published var characters: [MarvelCharacter] = []
    public var lock = false
    private let characterFetchService: CharacterFetchService
    
    //injecting the fetch service in the view model
    init(_ characterFetchService: CharacterFetchService = CharacterFetchService()) {
        self.characterFetchService = characterFetchService
    }
   
    //The caller is only aware of this method and not the fetch service
    func fetchCharacterList() {
        if lock {
            return
        }
        lock = true
        self.characterFetchService.fetchData(offset: characters.count) { (characterList, error) in
            if !characterList.isEmpty {
                for each in characterList {
                    DispatchQueue.main.async {
                        self.characters.append(each)
                    }
                }
                self.lock = false
            }
            if let _ = error {
                self.lock = false
            }
        }
    }
}
