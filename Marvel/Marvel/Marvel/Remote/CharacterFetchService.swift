//
//  CharacterFetchService.swift
//  Marvel
//
//  Created by Sharmin Khan on 31.08.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import Moya

// Network manager service to fetch the data from backend
class CharacterFetchService {
    
    typealias CompletionHandler = (_ result: [MarvelCharacter], _ error: Any?) -> ()
    var characterProvider = MoyaProvider<CharacterService>()
    
    func fetchData(offset: Int, completionHandler: @escaping CompletionHandler) {
        self.characterProvider.request(.getCharacters(offset: offset), callbackQueue: DispatchQueue.global(qos: .userInitiated), completion: { (res) in
            switch res {
            case .success(let response):
                do {
                    let characters: [MarvelCharacter] = try JSONDecoder().decode(MarvelCharacterContainer.self, from: response.data).characters
                    DispatchQueue.main.async {
                        completionHandler(characters,nil)
                    }
                }
                catch(let error) {
                    print("error")
                    completionHandler([],error)
                }
            case .failure:
                print("failure")
                completionHandler([],"Something went wrong with fetching the data")
            }
        })
        
        
    }
    
}
